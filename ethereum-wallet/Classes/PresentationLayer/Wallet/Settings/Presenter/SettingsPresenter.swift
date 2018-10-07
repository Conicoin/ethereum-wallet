// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit
import StoreKit

fileprivate extension BiometryType {
  
  var imageName: String {
    switch self {
    case .faceId:
      return R.image.pinFaceId.name
    default:
      return R.image.settingsFingerprint.name
    }
  }
}

class SettingsPresenter {
    
  weak var view: SettingsViewInput!
  weak var output: SettingsModuleOutput?
  var interactor: SettingsInteractorInput!
  var router: SettingsRouterInput!
  
  var currencies = Constants.Wallet.supportedCurrencies
  var selectedCurrency = Constants.Wallet.defaultCurrency
  
  private func setupTouchId() {
    let biometry = interactor.biometry
    view.setTouchId(title: Localized.settingsBiometic(biometry.label), image: biometry.imageName)
    view.setIsTouchIdEnabled(Defaults.isTouchIDAllowed)
  }
}


// MARK: - SettingsViewOutput

extension SettingsPresenter: SettingsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    setupTouchId()
    interactor.getWallet()
  }
  
  func didCurrencyPressed() {
    router.presentChooseCurrency(from: view.viewController, selectedIso: selectedCurrency, output: self)
  }
  
  func didChangePasscodePressed() {
    let oldPin = interactor.passphrase
    router.presentPinOnChangePin(from: view.viewController) { [unowned self] pin, routing in
      self.interactor.changePin(oldPin: oldPin, newPin: pin, completion: routing)
    }
  }
  
  func didBackupPressed() {
      router.presentPinOnBackup(from: view.viewController) { [unowned self] pin, routing in
        routing?(.success(true))
        
        switch self.interactor.accountType {
        case .mnemonic:
          self.router.presentMnemonicBackup(from: self.view.viewController)
        case .privateKey:
          self.interactor.getExportKeyUrl(passcode: pin)
        }
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
    view.setCurrency(currency)
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }
  
  func didReceiveExportKeyUrl(_ url: URL) {
    view.shareFileAtUrl(url)
  }
  
  func didFailedRegisterForRemoteNotification() {
    view.setPushSwitch(false)
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
    view.setCurrency(currency)
    interactor.selectCurrency(currency.iso)
  }
  
}
