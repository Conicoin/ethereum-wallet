// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import UIKit

class SendPresenter {
  
  weak var view: SendViewInput!
  weak var output: SendModuleOutput?
  var interactor: SendInteractorInput!
  var router: SendRouterInput!
    
  var coin: CoinDisplayable!
  
  private var amount: Decimal = 0
  private var address: String!
  
  private var settings = SendSettings(gasPrice: Constants.Send.defaultGasPrice,
                                      gasLimit: Constants.Send.defaultGasLimit,
                                      txData: nil)
  
  private var selectedCurrency = Constants.Wallet.defaultCurrency
  
  private func validate() {
    let isValid = amount != 0 &&
      settings.gasLimit != 0 &&
      address != nil && address.isValidAddress()
    view.inputDataIsValid(isValid)
  }
  
  private func calculateTotalAmount() {
    let fee = settings.gasLimit * settings.gasPrice
    interactor.getCheckout(for: coin, amount: amount, iso: selectedCurrency, fee: fee)
  }

}


// MARK: - SendViewOutput

extension SendPresenter: SendViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    view.setCoin(coin)
    interactor.getWallet()
    interactor.getGasPrice()
    calculateTotalAmount()
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
      self.interactor.sendTransaction(coin: self.coin, amount: self.amount, to: self.address, settings: self.settings, pin: pin, pinResult: routing)
    }
  }
  
  func didChangeAmount(_ amount: String) {
    let formated = amount.replacingOccurrences(of: ",", with: ".")
    self.amount = Decimal(formated)
    validate()
    calculateTotalAmount()
  }
  
  func didChangeAddress(_ address: String) {
    self.address = address
    validate()
  }
  
  func didChangeGasLimit(_ gasLimit: String) {
    var newValue = Decimal(gasLimit)
    if newValue == 0 {
      newValue = Constants.Send.defaultGasLimit
    }
    settings.gasLimit = newValue
    validate()
    calculateTotalAmount()
  }
  
  func didAdvancedPressed() {
    router.presentSendSettings(from: view.viewController, settings: settings, coin: coin, output: self)
  }
  
}


// MARK: - SendInteractorOutput

extension SendPresenter: SendInteractorOutput {
  func didReceiveWallet(_ wallet: Wallet) {
    self.selectedCurrency = wallet.localCurrency
    view.setCurrency(wallet.localCurrency)
  }
  
  func didReceiveGasLimit(_ gasLimit: Decimal) {
    settings.gasLimit = gasLimit
    calculateTotalAmount()
  }
  
  func didReceiveGasPrice(_ gasPrice: Decimal) {
    settings.gasPrice = gasPrice
    calculateTotalAmount()
  }
  
  func didReceiveCheckout(amount: String, total: String, fiatAmount: String, fee: String) {
    view.setCheckout(amount: amount, total: total, fiatAmount: fiatAmount, fee: fee)
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }
  
  func didFailedSending(with error: Error) {
    view.loadingFilure()
  }
}


// MARK: - SendModuleInput

extension SendPresenter: SendModuleInput {
  
  func presentSend(with coin: CoinDisplayable, from viewController: UIViewController) {
    self.coin = coin
    settings.gasLimit = coin.gasLimit
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
  }
  
}


// MARK: - SendSettingsModuleOutput

extension SendPresenter: SendSettingsModuleOutput {
  
  func didSelect(settings: SendSettings) {
    self.settings = settings
    calculateTotalAmount()
  }
  
}
