// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
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
