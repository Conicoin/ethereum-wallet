// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import Foundation
import Geth

protocol NodeProtocol {
  var chain: Chain { get }
  func start() throws
  func stop() throws
  func ethereumClient() throws -> GethEthereumClient
}

class Node: NodeProtocol {
  
  let chain: Chain
  private let gethNode: GethNode
  private var _ethereumClient: GethEthereumClient?
  
  init(chain: Chain) throws {
    self.chain = chain
    
    var error: NSError?
    let config = GethNewNodeConfig()!
    config.setEthereumGenesis(chain.genesis)
    config.setEthereumNetworkID(chain.chainId)
    config.setMaxPeers(25)
    
    if let bootNode = chain.enode {
      var error: NSError?
      let bootNodes = GethNewEnodesEmpty()!
      bootNodes.append(GethNewEnode(bootNode, &error))
    }
    
    if let stats = chain.netStats {
      config.setEthereumNetStats(stats)
    }
    
    let datadir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    gethNode = GethNewNode(datadir + chain.path, config, &error)
    
    guard error == nil else {
      throw error! as Error
    }
  }
  
  func start() throws {
    try gethNode.start()
  }
  
  func stop() throws {
    try gethNode.stop()
  }
  
  func ethereumClient() throws -> GethEthereumClient {
    if let client = _ethereumClient { return client }
    _ethereumClient = try gethNode.getEthereumClient()
    return _ethereumClient!
  }
}
