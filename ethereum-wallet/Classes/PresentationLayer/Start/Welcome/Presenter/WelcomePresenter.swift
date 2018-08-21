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


class WelcomePresenter {
    
  weak var view: WelcomeViewInput!
  weak var output: WelcomeModuleOutput?
  var interactor: WelcomeInteractorInput!
  var router: WelcomeRouterInput!
  
  var state = WelcomeState.new
    
}


// MARK: - WelcomeViewOutput

extension WelcomePresenter: WelcomeViewOutput {

  func viewIsReady() {
    view.setupInitialState(restoring: interactor.isRestoring)
  }

  func newDidPressed() {
    switch state {
    case .restore(let account):
      
      router.presentPinRestore(from: view.viewController) { [unowned self] pin, routing in
        switch account.type {
        case .privateKey:
          self.interactor.importPrivateKey(account.key, passcode: pin, completion: routing)
        case .mnemonic:
          self.interactor.importMnemonic(account.key, passcode: pin, completion: routing)
        }
      }
    
    case .new:
      router.presentPinNew(from: view.viewController) { [unowned self] pin, routing in
        self.interactor.createWallet(passcode: pin, completion: routing)
      }
    }
  }
  
  func didImportJsonKeyPressed() {
    router.presentImportJson(from: view.viewController)
  }
  
  func didImportPrivateKeyPressed() {
    router.presentImportPrivate(from: view.viewController)
  }
  
  func didImportMnemonicPressed() {
    router.presentImportMnemonic(from: view.viewController)
  }
  
}


// MARK: - WelcomeInteractorOutput

extension WelcomePresenter: WelcomeInteractorOutput {

}


// MARK: - WelcomeModuleInput

extension WelcomePresenter: WelcomeModuleInput {
  
  func present() {
    let navigationController = UINavigationController(rootViewController: view.viewController)
    AppDelegate.currentWindow.rootViewController = navigationController
  }

}
