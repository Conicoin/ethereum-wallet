// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.



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
