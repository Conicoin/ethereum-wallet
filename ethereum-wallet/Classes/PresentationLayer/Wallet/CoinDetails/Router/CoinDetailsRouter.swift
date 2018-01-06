//
//  CoinDetailsCoinDetailsRouter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class CoinDetailsRouter {

}


// MARK: - CoinDetailsRouterInput

extension CoinDetailsRouter: CoinDetailsRouterInput {
  
  func presentSend(for coin: Coin, from: UIViewController) {
    SendModule.create(with: coin).presentSend(from: from)
  }
  
  func presentReceive(for coin: Coin, from: UIViewController) {
    ReceiveModule.create().presentSend(for: coin, from: from)
  }
    
}
