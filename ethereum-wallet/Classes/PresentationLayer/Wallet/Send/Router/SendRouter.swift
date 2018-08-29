// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
