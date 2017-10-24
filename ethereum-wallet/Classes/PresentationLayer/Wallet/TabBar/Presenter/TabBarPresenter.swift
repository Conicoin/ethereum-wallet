//
//  TabBarTabBarPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class TabBarPresenter {
    
  weak var view: TabBarViewInput!
  weak var output: TabBarModuleOutput?
  var interactor: TabBarInteractorInput!
  var router: TabBarRouterInput!
  
  fileprivate lazy var balanceModule: BalanceModuleInput = BalanceModule.create()
  fileprivate lazy var transactionsModule: TransactionsModuleInput = TransactionsModule.create()
  
  fileprivate func insertViewControllers() {

    view.viewControllers = [
      balanceModule.viewController.wrapToNavigationController(),
      transactionsModule.viewController.wrapToNavigationController()
    ]
  }
  
}


// MARK: - TabBarViewOutput

extension TabBarPresenter: TabBarViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    insertViewControllers()
    interactor.startSynchronization()
  }
}


// MARK: - TabBarInteractorOutput

extension TabBarPresenter: TabBarInteractorOutput {
  
  func syncDidUpdateBalance(_ balance: Int64) {
    
  }
  
  func syncDidFailedWithError(_ error: Error) {
    DispatchQueue.main.async {
      error.showAllertIfNeeded(from: self.view.viewController)
    }
  }
  
  func syncDidChangeProgress(current: Int64, total: Int64) {
    balanceModule.syncDidChangeProgress(current: current, total: total)
  }
  
  func syncDidFinished() {
    balanceModule.syncDidFinished()
  }

}


// MARK: - TabBarModuleInput

extension TabBarPresenter: TabBarModuleInput {
  
  var viewController: UIViewController {
    return view.viewController
  }

}
