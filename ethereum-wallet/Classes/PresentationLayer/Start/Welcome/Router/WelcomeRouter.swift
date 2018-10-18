// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import UIKit

class WelcomeRouter {
  var app: Application!
  
  private func presentMainAfterAlerts(from viewController: UIViewController) {
    PopupModule.create(app: app, state: .touchId).present(from: viewController) { vc in
      PopupModule.create(app: self.app, state: .push).present(from: vc) { _ in
        TabBarModule.create(app: self.app, isSecureMode: false).present()
      }
    }
  }
  
  private func presentMnemonic(from viewController: UIViewController, completion: ((UIViewController) -> Void)?) {
    MnemonicModule.create(app: app).present(from: viewController, state: .create, completion: completion)
  }

}


// MARK: - WelcomeRouterInput

extension WelcomeRouter: WelcomeRouterInput {
  
  func presentPinNew(from viewController: UIViewController, postProcessor: PinPostProcess?) {
    let module =  PinModule.create(app: app, state: .set)
    module.present(from: viewController, postProcess: postProcessor) { [unowned self] vc in
      self.presentMnemonic(from: vc) { vc in
        self.presentMainAfterAlerts(from: vc)
      }
    }
  }
  
  func presentPinRestore(from viewController: UIViewController, postProcess: PinPostProcess?) {
    let module = PinModule.create(app: app, state: .restoreJson)
    module.present(from: viewController, postProcess: postProcess) { vc in
      self.presentMainAfterAlerts(from: vc)
    }
  }
  
  func presentImportJson(from viewController: UIViewController) {
    ImportModule.create(app: app, state: .jsonKey).present(from: viewController)
  }
  
  func presentImportPrivate(from viewController: UIViewController) {
    ImportModule.create(app: app, state: .privateKey).present(from: viewController)
  }
  
  func presentImportMnemonic(from viewController: UIViewController) {
    ImportModule.create(app: app, state: .mnemonic).present(from: viewController)
  }

    
}
