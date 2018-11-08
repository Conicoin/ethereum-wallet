// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

struct ChannelRepository {
  private let channelQueue = DispatchQueue(label: "ChannelQueue")
  
  lazy var transactionsChannel = Channel<[Transaction]>(queue: channelQueue)
  lazy var rateChannel = Channel<[Rate]>(queue: channelQueue)
  lazy var walletChannel = Channel<Wallet>(queue: channelQueue)
  lazy var tokenChannel = Channel<[TokenViewModel]>(queue: channelQueue)
  lazy var balanceChannel = Channel<BalanceViewModel>(queue: channelQueue)
}
