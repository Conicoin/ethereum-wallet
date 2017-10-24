//
//  TransactionsTransactionsPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import RealmSwift

class TransactionsPresenter {
    
  weak var view: TransactionsViewInput!
  weak var output: TransactionsModuleOutput?
  var interactor: TransactionsInteractorInput!
  var router: TransactionsRouterInput!
  
}


// MARK: - TransactionsViewOutput

extension TransactionsPresenter: TransactionsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    interactor.getTransactions()
  }
  
}


// MARK: - TransactionsInteractorOutput

extension TransactionsPresenter: TransactionsInteractorOutput {
  
  func didReceiveTransactions(_ transactions: [Transaction]) {
    view.didReceiveTransactions(transactions)
  }

}


// MARK: - TransactionsModuleInput

extension TransactionsPresenter: TransactionsModuleInput {
  
  var viewController: UIViewController {
    return view.viewController
  }

}
