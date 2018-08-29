// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit
import Geth

protocol EthereumCoreProtocol {
  var context: GethContext { get }
  var client: GethEthereumClient! { get } 
  func start(chain: Chain, delegate: SyncCoordinatorDelegate) throws
}

class Ethereum: EthereumCoreProtocol {

  static let core = Ethereum()
  static let syncQueue = DispatchQueue(label: "com.ethereum-wallet.sync")
  
  let context: GethContext = GethNewContext()
  var syncCoordinator: SyncCoordinatorProtocol!
  var client: GethEthereumClient!
  var chain: Chain!
  
  private init() {}
  
  func start(chain: Chain, delegate: SyncCoordinatorDelegate) throws {
    try syncCoordinator.startSync(chain: chain, delegate: delegate)
    self.client = try syncCoordinator.getClient()
    self.chain = chain
  }

}

