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


class SendRouter {

}


// MARK: - SendRouterInput

extension SendRouter: SendRouterInput {
  
  func presentScan(from: UIViewController, output: ScanModuleOutput) {
    ScanModule.create().present(from: from, output: output)
  }
  
  func presentChooseCurrency(from: UIViewController, selectedIso: String, output: ChooseCurrencyModuleOutput) {
    ChooseCurrencyModule.create().present(from: from, selectedIso: selectedIso, output: output)
  }
  
  func presentPin(from: UIViewController, amount: String, address: String, postProcess: PinPostProcess?) {
    let addressString = address[0..<4] + "..." + address[address.count - 4..<address.count]
    let pinModule = PinModule.create(.send(amount: amount, address: addressString))
    pinModule.present(from: from, postProcess: postProcess) { pinVC in
      let popupModule = PopupModule.create(.txSent(amount: amount, address: address))
      popupModule.present(from: pinVC) { popupVC in
        popupVC.popToRoot()
      }
    }
  }
  
  func presentSendSettings(from: UIViewController, settings: SendSettings, coin: CoinDisplayable, output: SendSettingsModuleOutput?) {
    SendSettingsModule.create().present(from: from, settings: settings, coin: coin, output: output)
  }
  
}
