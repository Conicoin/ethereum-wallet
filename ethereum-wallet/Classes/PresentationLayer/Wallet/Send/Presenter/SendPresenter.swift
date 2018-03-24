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
  private var gasLimit: Decimal = Constants.Send.defaultGasLimit
  private var gasPrice: Decimal = Constants.Send.defaultGasPrice
  
  private var selectedCurrency = Constants.Wallet.defaultCurrency
  
  private func validate() {
    let isValid = amount != 0 &&
      gasLimit != 0 &&
      address != nil && address.isValidAddress()
    view.inputDataIsValid(isValid)
  }
  
  private func calculateTotalAmount() {
    let fee = gasLimit * gasPrice
    interactor.getCheckout(for: coin, amount: amount, iso: selectedCurrency, fee: fee)
  }

}


// MARK: - SendViewOutput

extension SendPresenter: SendViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveCoin(coin)
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
    guard let rate = coin.rates.filter({ $0.to == selectedCurrency }).first else {
      return
    }
    let amountEther = amount.localToEther(rate: rate.value).toWei()
    
    view.showLoading()
    interactor.sendTransaction(amount: amountEther, to: address, gasLimit: gasLimit, gasPrice: gasPrice)
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
    self.gasLimit = newValue
    validate()
    calculateTotalAmount()
  }
  
}


// MARK: - SendInteractorOutput

extension SendPresenter: SendInteractorOutput {
  func didReceiveWallet(_ wallet: Wallet) {
    self.selectedCurrency = wallet.localCurrency
    view.didReceiveCurrency(wallet.localCurrency)
  }
  
  func didReceiveGasLimit(_ gasLimit: Decimal) {
    self.gasLimit = gasLimit
    calculateTotalAmount()
  }
  
  func didReceiveGasPrice(_ gasPrice: Decimal) {
    let reduced = gasPrice / 2
    self.gasPrice = reduced
    calculateTotalAmount()
  }
  
  func didSendTransaction() {
    view.loadingSuccess()
    view.popToRoot()
  }
  
  func didReceiveCheckout(amount: String, fiatAmount: String, fee: String) {
    view.didReceiveCheckout(amount: amount, fiatAmount: fiatAmount, fee: fee)
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }
  
  func didFailedSending(with error: Error) {
    view.loadingFilure()
    error.showAllertIfNeeded(from: view.viewController)
  }
}


// MARK: - SendModuleInput

extension SendPresenter: SendModuleInput {
  
  func presentSend(with coin: CoinDisplayable, from viewController: UIViewController) {
    self.coin = coin
    view.present(fromViewController: viewController)
  }
  
}


// MARK: - ScanModuleOutput

extension SendPresenter: ScanModuleOutput {
  
  func didDetectQRCode(_ code: String) {
    let rawAddress = code.retriveAddress()
    self.address = rawAddress
    view.didDetectQRCode(rawAddress)
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
    view.didReceiveCurrency(currency.iso)
    calculateTotalAmount()
  }
  
}
