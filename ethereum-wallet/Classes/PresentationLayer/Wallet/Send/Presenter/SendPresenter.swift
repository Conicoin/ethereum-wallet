// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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
    
  private var coin: Coin!
  private var amount: Decimal = 0
  private var address: String!
  private var gasLimit: Decimal = 21000
  private var gasPrice: Decimal = 2000000000 // 2 gwei
  
  private var selectedCurrency = Constants.Wallet.defaultCurrency
  
  private func validate() {
    let isValid = coin != nil &&
      amount != 0 &&
      gasLimit != 0 &&
      address != nil && address.isValidAddress()
    view.inputDataIsValid(isValid)
  }

  private func calculateTotalAmount() {
    let fee = gasPrice * gasLimit
    guard
      let rate = coin.rates.filter({ $0.to == selectedCurrency }).first else {
      return
    }
    let etherFee = Ether(fee as NSDecimalNumber)
    let etherAmount = amount / Decimal(rate.value)
    let etherTotal = Ether(etherAmount.etherToWei() as NSDecimalNumber)
    let feeAmount = fee.etherToLocal(rate: rate.value).weiToEther()
    let totalAmount = amount + feeAmount
    view.didChanged(totalAmount: totalAmount, totalEther: etherTotal, fee: feeAmount, feeEther: etherFee, iso: selectedCurrency)
  }
}


// MARK: - SendViewOutput

extension SendPresenter: SendViewOutput {
  
  func didCurrencyPressed() {
    router.presentChooseCurrency(from: view.viewController, output: self)
  }
  
  func didScanPressed() {
    router.presentScan(from: view.viewController, output: self)
  }
  
  func didSendPressed() {
    guard let rate = coin.rates.filter({ $0.to == selectedCurrency }).first else {
      return
    }
    let amountEther = amount.localToEther(rate: rate.value).etherToWei()
    
    view.showLoading()
    interactor.sendTransaction(amount: amountEther, to: address, gasLimit: gasLimit)
  }
  
  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveGasLimit(gasLimit)
    view.didReceiveGasPrice(gasPrice)
    interactor.getWallet()
    interactor.getCoin()
    interactor.getGasLimit()
    interactor.getGasPrice()
  }
  
  func didChangeAmount(_ amount: String) {
    self.amount = Decimal(string: amount) ?? 0
    validate()
    calculateTotalAmount()
  }
  
  func didChangeAddress(_ address: String) {
    self.address = address
    validate()
  }
  
  func didChangeGasLimit(_ gasLimit: String) {
    self.gasLimit = Decimal(string: gasLimit) ?? 0
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
    view.didReceiveGasLimit(gasLimit)
  }
  
  func didReceiveGasPrice(_ gasPrice: Decimal) {
    self.gasPrice = gasPrice
    calculateTotalAmount()
    view.didReceiveGasPrice(gasPrice)
  }
  
  func didSendTransaction() {
    view.loadingSuccess()
    view.dissmiss()
  }
  
  func didReceiveCoin(_ coin: Coin) {
    self.coin = coin
    calculateTotalAmount()
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
  
  var viewController: UIViewController {
    return view.viewController
  }
  
  func presentSend(from: UIViewController) {
    view.present(fromViewController: from)
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
  
  func didSelectCurrency(_ currency: String) {
    selectedCurrency = currency
    view.didReceiveCurrency(currency)
    calculateTotalAmount()
  }
  
}
