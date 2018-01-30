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


class SendTokenPresenter {
    
  weak var view: SendTokenViewInput!
  weak var output: SendTokenModuleOutput?
  var interactor: SendTokenInteractorInput!
  var router: SendTokenRouterInput!
  
  var token: Token!
  
  private var amount: Decimal = 0
  private var address: String!
  private var gasLimit: Decimal = 53000
  private var gasPrice: Decimal = 2000000000
  
  private var selectedCurrency = Constants.Wallet.defaultCurrency
  
  private func validate() {
    let isValid = amount != 0 &&
      gasLimit != 0 &&
      address != nil && address.isValidAddress()
    view.inputDataIsValid(isValid)
  }
  
  private func calculateTotalAmount() {
    let fee = gasLimit * gasPrice
    interactor.getCheckout(iso: selectedCurrency, fee: fee)
  }
    
}


// MARK: - SendTokenViewOutput

extension SendTokenPresenter: SendTokenViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveGasLimit(gasLimit)
    view.didReceiveGasPrice(gasPrice)
    view.didReceiveToken(token)
    interactor.getWallet()
    interactor.getGasLimit()
    interactor.getGasPrice()
    calculateTotalAmount()
  }
  
  func didSendPressed() {
    view.showLoading()
    interactor.sendTransaction(for: token, amount: amount, to: address, gasLimit: gasLimit, gasPrice: gasPrice)
  }
  
  func didScanPressed() {
    router.presentScan(from: view.viewController, output: self)
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
      newValue = Constants.Send.defaultGasLimitToken
    }
    self.gasLimit = newValue
    validate()
    calculateTotalAmount()
  }

}


// MARK: - SendTokenInteractorOutput

extension SendTokenPresenter: SendTokenInteractorOutput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    self.selectedCurrency = wallet.localCurrency
    calculateTotalAmount()
  }
  
  func didReceiveGasLimit(_ gasLimit: Decimal) {
    self.gasLimit = gasLimit
    calculateTotalAmount()
    view.didReceiveGasLimit(gasLimit)
  }
  
  func didReceiveGasPrice(_ gasPrice: Decimal) {
    let reduced = gasPrice / 2
    self.gasPrice = reduced
    calculateTotalAmount()
    view.didReceiveGasPrice(reduced)
  }
  
  func didSendTransaction() {
    view.loadingSuccess()
    view.popToRoot()
  }
  
  func didReceiveCheckout(ethFee: String, fiatFee: String) {
    view.didReceiveCheckout(ethFee: ethFee, fiatFee: fiatFee)
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }
  
  func didFailedSending(with error: Error) {
    view.loadingFilure()
    error.showAllertIfNeeded(from: view.viewController)
  }

}


// MARK: - SendTokenModuleInput

extension SendTokenPresenter: SendTokenModuleInput {
  
  func presentSendToken(with token: Token, from viewController: UIViewController) {
    self.token = token
    view.present(fromViewController: viewController)
  }
  
}


// MARK: - ScanModuleOutput

extension SendTokenPresenter: ScanModuleOutput {
  
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

