//
//  PasswordPasswordRouter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 20/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation
import UIKit

class PasswordRouter {

}


// MARK: - PasswordRouterInput

extension PasswordRouter: PasswordRouterInput {
  
  func presentWallet(from: UIViewController) {
    AppDelegate.currentWindow.rootViewController = TabBarModule.create().viewController
  }
    
}
