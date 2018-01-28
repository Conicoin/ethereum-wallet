//
//  SendTokenSendTokenRouterInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol SendTokenRouterInput: class {
  func presentScan(from: UIViewController, output: ScanModuleOutput)
}
