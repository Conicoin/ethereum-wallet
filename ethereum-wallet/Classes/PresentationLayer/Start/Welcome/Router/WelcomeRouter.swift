//
//  WelcomeWelcomeRouter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 19/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation
import UIKit

class WelcomeRouter {

}


// MARK: - WelcomeRouterInput

extension WelcomeRouter: WelcomeRouterInput {
  
  func presentPassword(from: UIViewController) {
    PasswordModule.create().present(from: from)
  }
    
}
