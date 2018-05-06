//
//  SendSettingsSendSettingsModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 02/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol SendSettingsModuleInput: class {
  var output: SendSettingsModuleOutput? { get set }
  func present(from viewController: UIViewController, settings: SendSettings, coin: CoinDisplayable, output: SendSettingsModuleOutput?)
}
