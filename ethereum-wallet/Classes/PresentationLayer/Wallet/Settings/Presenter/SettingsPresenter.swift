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


class SettingsPresenter {
    
  weak var view: SettingsViewInput!
  weak var output: SettingsModuleOutput?
  var interactor: SettingsInteractorInput!
  var router: SettingsRouterInput!
  
  var currencies = Constants.Wallet.supportedCurrencies
  
}


// MARK: - SettingsViewOutput

extension SettingsPresenter: SettingsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    interactor.getWallet()
  }
  
  func didSelectCurrency(at index: Int) {
    interactor.selectCurrency(currencies[index])
  }

}


// MARK: - SettingsInteractorOutput

extension SettingsPresenter: SettingsInteractorOutput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    guard let index = currencies.index(of: wallet.localCurrency) else { return }
    view.selectCurrency(at: index)
  }

}


// MARK: - SettingsModuleInput

extension SettingsPresenter: SettingsModuleInput {
  
  var viewController: UIViewController {
    return view.viewController
  }

}
