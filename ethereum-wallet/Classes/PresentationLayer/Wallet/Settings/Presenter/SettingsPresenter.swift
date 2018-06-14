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
import StoreKit


class SettingsPresenter {
    
  weak var view: SettingsViewInput!
  weak var output: SettingsModuleOutput?
  var interactor: SettingsInteractorInput!
  var router: SettingsRouterInput!
  
  var currencies = Constants.Wallet.supportedCurrencies
  var selectedCurrency = Constants.Wallet.defaultCurrency
}


// MARK: - SettingsViewOutput

extension SettingsPresenter: SettingsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveIsTouchIdEnabled(Defaults.isTouchIDAllowed)
    interactor.getWallet()
  }
  
  func didCurrencyPressed() {
    router.presentChooseCurrency(from: view.viewController, selectedIso: selectedCurrency, output: self)
  }
  
  func didChangePasscodePressed() {
    let keychain = Keychain()
    let oldPin = keychain.passphrase!
    router.presentPinOnChangePin(from: view.viewController) { [unowned self] pin, routing in
      self.interactor.changePin(oldPin: oldPin, newPin: pin, completion: routing)
    }
  }
  
  func didBackupPressed() {
    router.presentPinOnBackup(from: view.viewController) { [unowned self] pin, routing in
      routing?(.success(true))
      self.interactor.getExportKeyUrl(passcode: pin)
    }
  }
  
  func didTouchIdValueChanged(_ isOn: Bool) {
    Defaults.isTouchIDAllowed = isOn
  }
  
  func didPushValueChanged(_ isOn: Bool) {
    if isOn {
      interactor.registerForRemoteNotifications()
    } else {
      interactor.unregisterFromRemoteNotifications()
    }
  }
  
  func didRateAppPressed() {
    SKStoreReviewController.requestReview()
  }
  
  func didLogoutPressed() {
    router.presentPinOnExit(from: view.viewController) { [unowned self] pin, routing in
      self.interactor.clearAll(passphrase: pin, completion: routing)
    }
  }

}


// MARK: - SettingsInteractorOutput

extension SettingsPresenter: SettingsInteractorOutput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    selectedCurrency = wallet.localCurrency
    let currency = FiatCurrencyFactory.create(iso: wallet.localCurrency)
    view.didReceiveCurrency(currency)
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }
  
  func didReceiveExportKeyUrl(_ url: URL) {
    view.shareFileAtUrl(url)
  }
  
  func didFailedRegisterForRemoteNotification() {
    view.didFailedRegisterForRemoteNotification()
  }

}


// MARK: - SettingsModuleInput

extension SettingsPresenter: SettingsModuleInput {
  
  var viewController: UIViewController {
    return view.viewController
  }

}


// MARK: - ChooseCurrencyModuleOutput

extension SettingsPresenter: ChooseCurrencyModuleOutput {
  
  func didSelectCurrency(_ currency: FiatCurrency) {
    view.didReceiveCurrency(currency)
    interactor.selectCurrency(currency.iso)
  }
  
}
