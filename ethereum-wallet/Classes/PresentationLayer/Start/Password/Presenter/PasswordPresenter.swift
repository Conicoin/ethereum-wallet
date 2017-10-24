//
//  PasswordPasswordPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 20/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class PasswordPresenter {
    
  weak var view: PasswordViewInput!
  weak var output: PasswordModuleOutput?
  var interactor: PasswordInteractorInput!
  var router: PasswordRouterInput!
  
  fileprivate var password: String!
  fileprivate var restoring: Bool {
    return Keychain().isAccountBackuped
  }
    
}


// MARK: - PasswordViewOutput

extension PasswordPresenter: PasswordViewOutput {

  func viewIsReady() {
    view.setupInitialState(restoring: restoring)
  }
  
  func didConfirmPassword(_ password: String) {
    if restoring {
      interactor.restoreAccount(passphrase: password)
    } else {
      interactor.createAccount(passphrase: password)
    }
  }

}


// MARK: - PasswordInteractorOutput

extension PasswordPresenter: PasswordInteractorOutput {

  func didReceive(account: Account) {
    interactor.createWallet(address: account.address)
    router.presentWallet(from: view.viewController)
  }
  
  func didFailedAccountReceiving(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }
  
}


// MARK: - PasswordModuleInput

extension PasswordPresenter: PasswordModuleInput {
  
  func present(from: UIViewController) {
    let navigationController = UINavigationController(rootViewController: view.viewController)
    from.present(navigationController, animated: true, completion: nil)
  }

}
