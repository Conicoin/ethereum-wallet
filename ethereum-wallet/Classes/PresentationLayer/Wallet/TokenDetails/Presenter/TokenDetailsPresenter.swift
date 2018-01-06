//
//  TokenDetailsTokenDetailsPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class TokenDetailsPresenter {
    
  weak var view: TokenDetailsViewInput!
  weak var output: TokenDetailsModuleOutput?
  var interactor: TokenDetailsInteractorInput!
  var router: TokenDetailsRouterInput!
  
  var token: Token!
}


// MARK: - TokenDetailsViewOutput

extension TokenDetailsPresenter: TokenDetailsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveToken(token)
  }
  
  func didSendPressed() {
    router.presentSend(for: token, from: view.viewController)
  }
  
  func didReceivePressed() {
    router.presentReceive(for: token, from: view.viewController)
  }

}


// MARK: - TokenDetailsInteractorOutput

extension TokenDetailsPresenter: TokenDetailsInteractorOutput {

}


// MARK: - TokenDetailsModuleInput

extension TokenDetailsPresenter: TokenDetailsModuleInput {
  
  func present(with token: Token, from: UIViewController) {
    self.token = token
    view.present(fromViewController: from)
  }

}
