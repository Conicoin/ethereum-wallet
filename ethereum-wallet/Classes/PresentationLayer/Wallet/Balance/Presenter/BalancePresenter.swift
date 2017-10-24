//
//  BalanceBalancePresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class BalancePresenter {
    
  weak var view: BalanceViewInput!
  weak var output: BalanceModuleOutput?
  var interactor: BalanceInteractorInput!
  var router: BalanceRouterInput!
    
}


// MARK: - BalanceViewOutput

extension BalancePresenter: BalanceViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    interactor.getWallet()
  }

}


// MARK: - BalanceInteractorOutput

extension BalancePresenter: BalanceInteractorOutput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    view.didReceiveWallet(wallet)
  }
  

}


// MARK: - BalanceModuleInput

extension BalancePresenter: BalanceModuleInput {
  
  var viewController: UIViewController {
    return view.viewController
  }
  
  func syncDidChangeProgress(current: Int64, total: Int64) {
    view.syncDidChangeProgress(current: Float(current), total: Float(total))
  }
  
  func syncDidFinished() {
    view.syncDidFinished()
  }

}
