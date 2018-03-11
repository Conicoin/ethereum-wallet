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
  
  var isRestoring: Bool {
    let keychain = Keychain()
    return keychain.isAccountBackuped
  }
    
}


// MARK: - WelcomeViewOutput

extension WelcomePresenter: WelcomeViewOutput {

  func viewIsReady() {
    view.setupInitialState(restoring: isRestoring)
  }

  func newDidPressed() {
    router.presentPassword(from: view.viewController)
  }
  
  func importDidPressed() {
    router.presentImport(from: view.viewController)
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
