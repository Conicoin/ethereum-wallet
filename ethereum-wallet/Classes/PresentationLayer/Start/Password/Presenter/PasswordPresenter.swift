//  MIT License
//
//  Copyright (c) 2017 Artur Guseinov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
