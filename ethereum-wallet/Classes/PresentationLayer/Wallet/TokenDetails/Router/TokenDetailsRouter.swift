//
//  TokenDetailsTokenDetailsRouter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class TokenDetailsRouter {

}


// MARK: - TokenDetailsRouterInput

extension TokenDetailsRouter: TokenDetailsRouterInput {
  
  func presentSend(for token: Token, from: UIViewController) {
    SendModule.create(with: token).presentSend(from: from)
  }
  
  func presentReceive(for token: Token, from: UIViewController) {
    ReceiveModule.create().presentSend(for: token, from: from)
  }
    
}
