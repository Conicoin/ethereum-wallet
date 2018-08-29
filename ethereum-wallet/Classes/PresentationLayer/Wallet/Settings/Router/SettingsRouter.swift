// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit


class SettingsRouter {

}


// MARK: - SettingsRouterInput

extension SettingsRouter: SettingsRouterInput {
  
  func presentMnemonicBackup(from: UIViewController) {
    MnemonicModule.create().presentModal(from: from, state: .backup) { vc in
      vc.dismiss(animated: true, completion: nil)
    }
  }
  
  func presentChooseCurrency(from: UIViewController, selectedIso: String, output: ChooseCurrencyModuleOutput) {
    ChooseCurrencyModule.create().present(from: from, selectedIso: selectedIso, output: output)
  }
  
  func presentPinOnExit(from: UIViewController, postProcess: PinPostProcess?) {
    PinModule.create(.exit).present(from: from, postProcess: postProcess) { vc in
      WelcomeModule.create().present(state: .new)
    }
  }
  
  func presentPinOnChangePin(from: UIViewController, postProcess: PinPostProcess?) {
    PinModule.create(.change).present(from: from, postProcess: postProcess) { vc in
      vc.pop()
    }
  }
  
  func presentPinOnBackup(from: UIViewController, postProcess: PinPostProcess?) {
    PinModule.create(.backup).present(from: from, postProcess: postProcess) { vc in
      vc.pop()
    }
  }
    
}
