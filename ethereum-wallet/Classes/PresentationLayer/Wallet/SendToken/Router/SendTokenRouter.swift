//
//  SendTokenSendTokenRouter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class SendTokenRouter {

}


// MARK: - SendTokenRouterInput

extension SendTokenRouter: SendTokenRouterInput {
  
  func presentScan(from: UIViewController, output: ScanModuleOutput) {
    ScanModule.create().present(from: from, output: output)
  }
    
}
