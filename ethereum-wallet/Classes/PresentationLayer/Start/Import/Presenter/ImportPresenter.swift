// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import UIKit


class ImportPresenter {
    
  weak var view: ImportViewInput!
  weak var output: ImportModuleOutput?
  var interactor: ImportInteractorInput!
  var router: ImportRouterInput!
  var state: ImportStateProtocol!
    
}


// MARK: - ImportViewOutput

extension ImportPresenter: ImportViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveState(state)
  }
  
  func didConfirmKey(_ key: String) {
    interactor.verifyKey(key)
  }
  
  func closeDidPressed() {
    view.dissmissModal()
  }

}


// MARK: - ImportInteractorOutput

extension ImportPresenter: ImportInteractorOutput {
  
  func didConfirmValidKey(_ key: Data) {
    router.presentPin(from: view.viewController, key: key, importType: state.importType) { [unowned self] pin, postProcess in
      self.interactor.importKey(key, passcode: pin, completion: postProcess)
    }
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }

}


// MARK: - ImportModuleInput

extension ImportPresenter: ImportModuleInput {
  
  func present(from viewController: UIViewController) {
    view.present(fromViewController: viewController)
  }

}
