//
//  CoinSendable.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 24/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol CoinSendable {
  var balance: Currency! { get }
  var rates: [Rate] { get }
  var contractAddress: String? { get }
}

extension Token: CoinSendable {
  var contractAddress: String? {
    return address
  }
}

extension Coin: CoinSendable {
  
  var contractAddress: String? {
    return nil
  }
  
}
