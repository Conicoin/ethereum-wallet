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


import Foundation
import UIKit

class ImportRouter {
  
  private func presentMainAfterAlerts(from viewController: UIViewController) {
    PopupModule.create(.touchId).present(from: viewController) { vc in
      PopupModule.create(.push).present(from: vc) { _ in
        TabBarModule.create(isSecureMode: false).present()
      }
    }
  }
  
}


// MARK: - ImportRouterInput

extension ImportRouter: ImportRouterInput {
  
  func presentPin(from viewController: UIViewController, key: WalletKey, postProcess: PinPostProcess?) {
    switch key {
    case .jsonKey:
      let module = PinModule.create(.restoreJson)
      module.present(from: viewController, postProcess: postProcess) { [unowned self] vc in
        self.presentMainAfterAlerts(from: vc)
      }
      
    case .privateKey:
      let module = PinModule.create(.restorePrivate)
      module.present(from: viewController, postProcess: postProcess) { [unowned self] vc in
        self.presentMainAfterAlerts(from: vc)
      }
      
    case .mnemonic:
      let module = PinModule.create(.restoreJson)
      module.present(from: viewController, postProcess: postProcess) { [unowned self] vc in
        self.presentMainAfterAlerts(from: vc)
      }
      
    }
  }
    
}
