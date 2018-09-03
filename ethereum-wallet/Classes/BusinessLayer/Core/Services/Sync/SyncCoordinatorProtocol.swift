// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Geth

protocol SyncCoordinatorProtocol {
  func startSync(chain: Chain, delegate: SyncCoordinatorDelegate) throws
  func getClient() throws -> GethEthereumClient 
}
