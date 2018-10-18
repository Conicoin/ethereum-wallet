// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import UIKit

class ImportRouter {
  
  var app: Application!
  
  private func presentMainAfterAlerts(from viewController: UIViewController) {
    PopupModule.create(app: app, state: .touchId).present(from: viewController) { vc in
      PopupModule.create(app: self.app, state: .push).present(from: vc) { _ in
        TabBarModule.create(app: self.app, isSecureMode: false).present()
      }
    }
  }
  
}


// MARK: - ImportRouterInput

extension ImportRouter: ImportRouterInput {
  
  func presentPin(from viewController: UIViewController, key: WalletKey, postProcess: PinPostProcess?) {
    switch key {
    case .jsonKey:
      let module = PinModule.create(app: app, state: .restoreJson)
      module.present(from: viewController, postProcess: postProcess) { [unowned self] vc in
        self.presentMainAfterAlerts(from: vc)
      }
      
    case .privateKey:
      let module = PinModule.create(app: app, state: .restorePrivate)
      module.present(from: viewController, postProcess: postProcess) { [unowned self] vc in
        self.presentMainAfterAlerts(from: vc)
      }
      
    case .mnemonic:
      let module = PinModule.create(app: app, state: .restoreJson)
      module.present(from: viewController, postProcess: postProcess) { [unowned self] vc in
        self.presentMainAfterAlerts(from: vc)
      }
      
    }
  }
    
}
