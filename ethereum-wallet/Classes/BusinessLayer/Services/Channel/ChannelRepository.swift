//
//  ChannelRepository.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct ChannelRepository {
  private let channelQueue = DispatchQueue(label: "ChannelQueue")
  
  lazy var transactionsChannel = Channel<[Transaction]>(queue: channelQueue)
  lazy var rateChannel = Channel<[Rate]>(queue: channelQueue)
  lazy var walletChannel = Channel<Wallet>(queue: channelQueue)
  lazy var tokenChannel = Channel<[TokenViewModel]>(queue: channelQueue)
  lazy var balanceChannel = Channel<BalanceViewModel>(queue: channelQueue)
}
