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


import Foundation
import Geth
import ObjectMapper

struct Transaction {
  var txHash: String!
  var blockNumber: Int64!
  var timeStamp = Date()
  var nonce: Int64!
  var from: String!
  var to: String!
  var gas: Decimal!
  var gasPrice: Decimal!
  var gasUsed: Decimal!
  var error: String!
  var amount: Currency!
  var tokenMeta: TokenMeta?
  var isPending = false

  
  static func mapFromGethTransaction(_ object: GethTransaction, time: TimeInterval) -> Transaction {
    var tx = Transaction()
    tx.txHash = object.getHash().getHex()
    tx.blockNumber = 0
    tx.timeStamp = Date(timeIntervalSince1970: time)
    tx.nonce = object.getNonce()
    tx.from = ""
    tx.to = object.getTo().getHex()
    tx.gas = Decimal(object.getGas())
    tx.gasPrice = Decimal(object.getGasPrice().string())
    tx.gasUsed = Decimal(object.getCost().string())
    tx.error = ""
    tx.amount = Ether(weiString: object.getValue().string()!)
    return tx
  }
  
}

// MARK: - RealmMappable

extension Transaction: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmTransaction) -> Transaction {
    var tx = Transaction()
    tx.txHash = object.txHash
    tx.blockNumber = object.blockNumber
    tx.timeStamp = object.timeStamp
    tx.nonce = object.nonce
    tx.gas = Decimal(object.gas)
    tx.gasPrice = Decimal(object.gasPrice)
    tx.gasUsed = Decimal(object.gasUsed)
    tx.error = object.error
    tx.isPending = object.isPending
    tx.from = object.from
    tx.to = object.to
    
    if let meta = object.tokenMeta {
      tx.amount = TokenValue(weiString: object.value, name: meta.name, iso: meta.symbol, decimals: meta.decimals)
    } else {
      tx.amount = Ether(weiString: object.value)
    }

    return tx
  }
  
  func mapToRealmObject() -> RealmTransaction {
    let realmObject = RealmTransaction()
    realmObject.txHash = txHash
    realmObject.blockNumber = blockNumber
    realmObject.timeStamp = timeStamp
    realmObject.nonce = nonce
    realmObject.gas = gas.string
    realmObject.gasPrice = gasPrice.string
    realmObject.gasUsed = gasUsed.string
    realmObject.error = error
    realmObject.isPending = isPending
    realmObject.value = (amount.raw / 1e18).string
    realmObject.from = from
    realmObject.to = to
    
    if let meta = tokenMeta {
      realmObject.tokenMeta = meta.mapToRealmObject()
    }
    
    
    
    return realmObject
  }
  
}

// MARK: - ImmutableMappable

extension Transaction: ImmutableMappable {
  
  init(map: Map) throws {
    txHash = try map.value("id")
    blockNumber = try map.value("blockNumber")
    timeStamp = try map.value("timeStamp", using: DateTransform())
    nonce = try map.value("nonce")
    from = try map.value("from")
    error = try map.value("error")
    gas = try map.value("gas")
    gasPrice = try map.value("gasPrice")
    gasUsed = try map.value("gasUsed")
    
    let input: Data = try map.value("input", using: HexDataTransform())
    let txMetaChain = TxMetaChain()
    let type = txMetaChain.resolve(input: input)
    switch type {
    case .erc20(let to, let value):
      let meta: TokenMeta = try map.value("operations.0.contract")
      self.tokenMeta = meta
      self.to = to
      self.amount = TokenValue(weiString: value, name: meta.name, iso: meta.symbol, decimals: meta.decimals)
    default:
      self.to = try map.value("to")
      let value: String = try map.value("0")
      self.amount = Ether.init(weiString: value)
    }
  }
  
}
