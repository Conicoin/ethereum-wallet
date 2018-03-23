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
  
}


// MARK: - ImportRouterInput

extension ImportRouter: ImportRouterInput {
  
  func presentPin(from viewController: UIViewController, key: Data, importType: ImportState, postProcess: PinPostProcess?) {
    
    var pinState: PinState!
    switch importType {
    case .jsonKey:
      pinState = .restoreJson(key: key)
    case .privateKey:
      pinState = .restorePrivate(key: key)
    }
    
    PinModule.create(pinState).present(from: viewController, postProcess: postProcess) { vc in
      PopupModule.create(.touchId).present(from: vc) { _ in
        TabBarModule.create(isSecureMode: false).present()
      }
    }
  }
    
}
