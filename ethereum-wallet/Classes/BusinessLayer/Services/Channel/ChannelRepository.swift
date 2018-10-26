//
//  ChannelRepository.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct ChannelRepository {
  let transactionsChannel = Channel<[Transaction]>(queue: DispatchQueue(label: "ChannelQueue_transaction"))
  let rateChannel = Channel<[Rate]>(queue: DispatchQueue(label: "ChannelQueue_rate"))
  let walletChannel = Channel<Wallet>(queue: DispatchQueue(label: "ChannelQueue_wallet"))
}
