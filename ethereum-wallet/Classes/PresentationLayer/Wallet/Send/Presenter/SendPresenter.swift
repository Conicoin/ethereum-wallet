// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

class SendPresenter {
  
  weak var view: SendViewInput!
  weak var output: SendModuleOutput?
  var interactor: SendInteractorInput!
  var router: SendRouterInput!
  
  var coin: AbstractCoin!
  private var wallet: Wallet!
  private var settings: SendSettings = {
    return SendSettings(gasPrice: Constants.Send.defaultGasPrice,
                        gasLimit: Constants.Send.defaultGasLimit,
                        txData: nil)
  }()
  private var amount: Decimal = 0 {
    didSet {
      validate()
    }
  }
  private var address: String!{
    didSet {
      validate()
    }
  }
  
  private var selectedCurrency = Constants.Wallet.defaultCurrency
  
  private func validate() {
    let isValid = amount != 0
      && settings.gasLimit != 0
      && address != nil
      && address.isValidAddress()
    
    view.inputDataIsValid(isValid)
    calculateTotalAmount()
    
    guard isValid else { return }
    interactor.getGasLimit(from: wallet.address,
                           to: address,
                           amount: amount,
                           settings: settings)
  }
  
  private func calculateTotalAmount() {
    let fee = settings.gasLimit * settings.gasPrice
    let checkout = coin.checkout(amount: amount, iso: selectedCurrency, fee: fee)
    view.setCheckout(amount: checkout.amount, total: checkout.total, fee: checkout.fee)
  }
  
  private func updateLocalAmount() {
    let fiatAmountString = coin.fiatString(amount: amount, iso: selectedCurrency)
    view.setLocalAmount(fiatAmountString)
  }
  
}


// MARK: - SendViewOutput

extension SendPresenter: SendViewOutput {
  
  func viewIsReady() {
    settings.gasLimit = coin.gasLimit
    view.setupInitialState()
    view.setCoin(coin)
    interactor.getWallet()
    interactor.getGasPrice()
    updateLocalAmount()
  }
  
  func didCurrencyPressed() {
    router.presentChooseCurrency(from: view.viewController, selectedIso: selectedCurrency, output: self)
  }
  
  func didScanPressed() {
    router.presentScan(from: view.viewController, output: self)
  }
  
  func didSendPressed() {
    let amountString = coin.amountString(with: amount)
    router.presentPin(from: view.viewController, amount: amountString, address: address) { [unowned self] pin, routing in
      self.interactor.sendTransaction(amount: self.amount, to: self.address, settings: self.settings, pin: pin, pinResult: routing)
    }
  }
  
  func didChangeAmount(_ amount: String) {
    let formated = amount.replacingOccurrences(of: ",", with: ".")
    self.amount = Decimal(formated)
    self.updateLocalAmount()
  }
  
  func didChangeAddress(_ address: String) {
    self.address = address
  }
  
  func didAdvancedPressed() {
    router.presentSendSettings(from: view.viewController, settings: settings, coin: coin, output: self)
  }
  
}


// MARK: - SendInteractorOutput

extension SendPresenter: SendInteractorOutput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    self.wallet = wallet
    self.selectedCurrency = wallet.localCurrency
    view.setCurrency(wallet.localCurrency)
  }
  
  func didReceiveGasLimit(_ gasLimit: Decimal) {
    settings.gasLimit = gasLimit
    calculateTotalAmount()
  }
  
  func didReceiveGasPrice(_ gasPrice: Decimal) {
    settings.gasPrice = gasPrice
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }
  
  func didFailedSending(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
    view.loadingFilure()
  }
}


// MARK: - SendModuleInput

extension SendPresenter: SendModuleInput {
  
  func presentSend(from viewController: UIViewController) {
    view.present(fromViewController: viewController)
  }
  
}


// MARK: - ScanModuleOutput

extension SendPresenter: ScanModuleOutput {
  
  func didDetectQRCode(_ code: String) {
    let rawAddress = code.retriveAddress()
    self.address = rawAddress
    view.setAddressFromQR(rawAddress)
    validate()
  }
  
  func didFailedQRCapture(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }
  
}


// MARK: - ChooseCurrencyModuleOutput

extension SendPresenter: ChooseCurrencyModuleOutput {
  
  func didSelectCurrency(_ currency: FiatCurrency) {
    selectedCurrency = currency.iso
    view.setCurrency(currency.iso)
    calculateTotalAmount()
    updateLocalAmount()
  }
  
}


// MARK: - SendSettingsModuleOutput

extension SendPresenter: SendSettingsModuleOutput {
  
  func didSelect(settings: SendSettings) {
    self.settings = settings
    calculateTotalAmount()
  }
  
}
