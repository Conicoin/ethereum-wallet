//
//  ImportImportPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class ImportPresenter {
    
  weak var view: ImportViewInput!
  weak var output: ImportModuleOutput?
  var interactor: ImportInteractorInput!
  var router: ImportRouterInput!
    
}


// MARK: - ImportViewOutput

extension ImportPresenter: ImportViewOutput {

  func viewIsReady() {
    view.setupInitialState()
  }
  
  func didConfirmJsonKey(_ jsonKey: String) {
    interactor.importJsonKey(jsonKey)
  }
  
  func closeDidPressed() {
    view.dissmissModal()
  }

}


// MARK: - ImportInteractorOutput

extension ImportPresenter: ImportInteractorOutput {
  
  func didConfirmValidJsonKey() {
    router.presentPassword(from: view.viewController)
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }

}


// MARK: - ImportModuleInput

extension ImportPresenter: ImportModuleInput {
  
  func present(from viewController: UIViewController) {
    let navigationController = UINavigationController(rootViewController: view.viewController)
    viewController.present(navigationController, animated: true, completion: nil)
  }

}
