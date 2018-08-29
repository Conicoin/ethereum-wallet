// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit
import SafariServices

class TransactionDetailsPresenter {
    
  weak var view: TransactionDetailsViewInput!
  weak var output: TransactionDetailsModuleOutput?
  var interactor: TransactionDetailsInteractorInput!
  var router: TransactionDetailsRouterInput!
  
  private var displayer: TransactionDisplayer!
    
}


// MARK: - TransactionDetailsViewOutput

extension TransactionDetailsPresenter: TransactionDetailsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveTransaction(displayer)
  }

  func didEtherscanPressed() {
    view.viewController.showAlert(title: Localized.txDetailsAlertTitle(), message: nil, cancelable: true) { [unowned self] _ in
      self.router.presentEtherscan(with: self.displayer.tx.txHash, from: self.view.viewController)
    }
  }
}


// MARK: - TransactionDetailsInteractorOutput

extension TransactionDetailsPresenter: TransactionDetailsInteractorOutput {

}


// MARK: - TransactionDetailsModuleInput

extension TransactionDetailsPresenter: TransactionDetailsModuleInput {
    
  func present(with displayer: TransactionDisplayer, from viewController: UIViewController) {
    self.displayer = displayer
    view.viewController.modalPresentationStyle = .overCurrentContext
    view.presentModal(fromViewController: viewController)
  }

}
