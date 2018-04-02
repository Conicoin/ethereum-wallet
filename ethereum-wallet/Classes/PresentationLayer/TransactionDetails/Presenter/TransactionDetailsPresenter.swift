//
//  TransactionDetailsTransactionDetailsPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 01/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit
import SafariServices

class TransactionDetailsPresenter {
    
  weak var view: TransactionDetailsViewInput!
  weak var output: TransactionDetailsModuleOutput?
  var interactor: TransactionDetailsInteractorInput!
  var router: TransactionDetailsRouterInput!
  
  private var txIndex: TxIndex!
  private var transaction: TransactionDisplayable?
    
}


// MARK: - TransactionDetailsViewOutput

extension TransactionDetailsPresenter: TransactionDetailsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveTxIndex(txIndex)
    interactor.getTransaction(txHash: txIndex.txHash)
  }

  func didEtherscanPressed() {
    view.viewController.showAlert(title: Localized.txDetailsAlertTitle(), message: nil, cancelable: true) { [unowned self] _ in
      self.router.presentEtherscan(with: self.txIndex.txHash, from: self.view.viewController)
    }
  }
}


// MARK: - TransactionDetailsInteractorOutput

extension TransactionDetailsPresenter: TransactionDetailsInteractorOutput {
  
  func didReceiveTransaction(_ transaction: TransactionDisplayable) {
    view.didReceiveTransaction(transaction)
  }

}


// MARK: - TransactionDetailsModuleInput

extension TransactionDetailsPresenter: TransactionDetailsModuleInput {
    
  func present(with txIndex: TxIndex, from viewController: UIViewController) {
    self.txIndex = txIndex
    view.viewController.modalPresentationStyle = .overCurrentContext
    view.presentModal(fromViewController: viewController)
  }

}
