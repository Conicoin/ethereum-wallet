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


class SettingsRouter {

}


// MARK: - SettingsRouterInput

extension SettingsRouter: SettingsRouterInput {
  
  func presentChooseCurrency(from: UIViewController, selectedIso: String, output: ChooseCurrencyModuleOutput) {
    ChooseCurrencyModule.create().present(from: from, selectedIso: selectedIso, output: output)
  }
  
  func presentPinOnExit(from: UIViewController, postProcess: PinPostProcess?) {
    PinModule.create(.exit).present(from: from, postProcess: postProcess) { vc in
      WelcomeModule.create(.new).present()
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
