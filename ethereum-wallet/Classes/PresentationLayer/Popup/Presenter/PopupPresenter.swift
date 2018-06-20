//
//  PopupPopupPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class PopupPresenter {
    
  weak var view: PopupViewInput!
  weak var output: PopupModuleOutput?
  var interactor: PopupInteractorInput!
  var router: PopupRouterInput!
  
  var popupState: PopupStateProtocol!
  var completion: ((UIViewController) -> Void)!
    
}


// MARK: - PopupViewOutput

extension PopupPresenter: PopupViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    view.setState(popupState)
  }
  
  func didConfirmPressed() {
    interactor.executePostProcess()
  }
  
  func didSkipPressed() {
    completion(view.viewController)
  }

}


// MARK: - PopupInteractorOutput

extension PopupPresenter: PopupInteractorOutput {
  func postProcessDidSucced() {
    completion(view.viewController)
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }

}


// MARK: - PopupModuleInput

extension PopupPresenter: PopupModuleInput {
  
  func present(from viewController: UIViewController, completion: @escaping (UIViewController) -> Void) {
    self.completion = completion
    view.present(fromViewController: viewController)
  }

}
