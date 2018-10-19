//
//  ChannelRepository.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct ChannelRepository {
  let coinChannel = Channel<Coin>()
  let tokenChannel = Channel<[Token]>()
  let transactionsChannel = Channel<[Transaction]>()
  let rateChannel = Channel<[Rate]>()
  let walletChannel = Channel<Wallet>()
}
