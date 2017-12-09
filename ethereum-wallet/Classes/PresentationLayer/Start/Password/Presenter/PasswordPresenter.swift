// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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


class PasswordPresenter {
    
  weak var view: PasswordViewInput!
  weak var output: PasswordModuleOutput?
  var interactor: PasswordInteractorInput!
  var router: PasswordRouterInput!
  
  var chains = Chain.all()
  var selectedChain = Chain.default
  
  var syncMode = SyncMode.standard
  
  private var password: String!
  private var restoring: Bool {
    return Keychain().isAccountBackuped
  }
  
}


// MARK: - PasswordViewOutput

extension PasswordPresenter: PasswordViewOutput {

  func viewIsReady() {
    view.setupInitialState(restoring: restoring)
    view.didChangedMode(syncMode)
  }
  
  func viewIsAppear() {
    let index = chains.index(of: selectedChain)!
    view.selectChain(at: index)
  }
  
  func didConfirmPassword(_ password: String) {
    if restoring {
      interactor.restoreAccount(passphrase: password)
    } else {
      interactor.createAccount(passphrase: password)
    }
  }
  
  func selectChain(at index: Int) {
    Defaults.chain = chains[index]
  }
  
  func didChangeSyncMode(_ value: Bool) {
    syncMode = SyncMode(rawValue: value.intValue)!
    Defaults.mode = syncMode
    view.didChangedMode(syncMode)
  }

}


// MARK: - PasswordInteractorOutput

extension PasswordPresenter: PasswordInteractorOutput {

  func didReceive(account: Account) {
    interactor.createWallet(address: account.address)
    router.presentWallet(from: view.viewController, isSecureMode: syncMode.isSecureMode)
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
