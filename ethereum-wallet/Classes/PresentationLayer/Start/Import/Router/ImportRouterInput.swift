// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol ImportRouterInput: class {
  func presentPin(from viewController: UIViewController, key: WalletKey, postProcess: PinPostProcess?)
}
