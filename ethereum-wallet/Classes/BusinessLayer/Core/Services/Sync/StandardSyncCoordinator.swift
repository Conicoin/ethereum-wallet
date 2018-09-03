// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Geth

class StandardSyncCoordinator: SyncCoordinatorProtocol {
  
  private var chain: Chain!
  
  func startSync(chain: Chain, delegate: SyncCoordinatorDelegate) throws {
    self.chain = chain
    delegate.syncDidFinished()
  }
  
  func getClient() throws -> GethEthereumClient {
    var error: NSError?
    let client =  GethNewEthereumClient(chain.clientUrl, &error)
    guard error == nil else {
      throw error!
    }
    return client!
  }

}
