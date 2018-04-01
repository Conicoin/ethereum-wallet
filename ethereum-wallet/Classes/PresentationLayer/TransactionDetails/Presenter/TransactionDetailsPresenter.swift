//
//  TransactionDetailsTransactionDetailsPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 01/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class TransactionDetailsPresenter {
    
  weak var view: TransactionDetailsViewInput!
  weak var output: TransactionDetailsModuleOutput?
  var interactor: TransactionDetailsInteractorInput!
  var router: TransactionDetailsRouterInput!
  
  private var txHash: String!
    
}


// MARK: - TransactionDetailsViewOutput

extension TransactionDetailsPresenter: TransactionDetailsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
  }

}


// MARK: - TransactionDetailsInteractorOutput

extension TransactionDetailsPresenter: TransactionDetailsInteractorOutput {

}


// MARK: - TransactionDetailsModuleInput

extension TransactionDetailsPresenter: TransactionDetailsModuleInput {
    
  func present(with txHash: String, from viewController: UIViewController) {
    self.txHash = txHash
    view.viewController.modalPresentationStyle = .overCurrentContext
    view.presentModal(fromViewController: viewController)
  }

}
