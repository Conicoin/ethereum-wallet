// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation
import Geth

class PendingTxBuilder {
  
  func build(_ gethTx: GethTransaction, from: String, time: Date, txMeta: TokenMeta?) -> Transaction {
    var tx = Transaction()
    tx.txHash = gethTx.getHash().getHex()
    tx.blockNumber = 0
    tx.timeStamp = time
    tx.nonce = gethTx.getNonce()
    tx.from = from
    tx.to = gethTx.getTo().getHex()
    tx.gas = Decimal(gethTx.getGas())
    tx.gasPrice = Decimal(gethTx.getGasPrice().getString(10))
    tx.gasUsed = tx.gas
    tx.error = ""
    tx.tokenMeta = txMeta
    
    tx.amount = Ether(weiString: gethTx.getValue().string()!)
    
    if let meta = txMeta {
      tx.tokenMeta = meta
      
      // Resolve tx type
      let chain = TxMetaChain()
      let type = chain.resolve(input: gethTx.getData())
      switch type {
      case .erc20(let to, let value):
        tx.to = to
        tx.amount = TokenValue(wei: Decimal(value), name: meta.name, iso: meta.iso, decimals: meta.decimals)
      default:
        break
      }
    }
    
    return tx
  }
  
}
