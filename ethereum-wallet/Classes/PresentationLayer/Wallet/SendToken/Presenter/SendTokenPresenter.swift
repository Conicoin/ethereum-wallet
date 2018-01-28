//
//  SendTokenSendTokenPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class SendTokenPresenter {
    
  weak var view: SendTokenViewInput!
  weak var output: SendTokenModuleOutput?
  var interactor: SendTokenInteractorInput!
  var router: SendTokenRouterInput!
  
  var token: Token!
  
  private var amount: Decimal = 0
  private var address: String!
  private var gasLimit: Decimal = 21000
  private var gasPrice: Decimal = 2000000000 // 2 gwei
  
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
    interactor.sendTransaction(for: token, amount: amount, to: address, gasLimit: gasLimit)
  }
  
  func didScanPressed() {
    router.presentScan(from: view.viewController, output: self)
  }
  
  func didChangeAmount(_ amount: String) {
    self.amount = Decimal(amount)
    validate()
    calculateTotalAmount()
  }
  
  func didChangeAddress(_ address: String) {
    self.address = address
    validate()
  }
  
  func didChangeGasLimit(_ gasLimit: String) {
    self.gasLimit = Decimal(gasLimit)
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
    self.gasPrice = gasPrice
    calculateTotalAmount()
    view.didReceiveGasPrice(gasPrice)
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

