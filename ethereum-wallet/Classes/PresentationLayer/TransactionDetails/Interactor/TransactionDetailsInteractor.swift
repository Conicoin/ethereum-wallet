//
//  TransactionDetailsTransactionDetailsInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 01/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


class TransactionDetailsInteractor {
  weak var output: TransactionDetailsInteractorOutput!
  
  var txStorage: TransactionDisplayableStorage!
}


// MARK: - TransactionDetailsInteractorInput

extension TransactionDetailsInteractor: TransactionDetailsInteractorInput {
  
  func getTransaction(txHash: String) {
    DispatchQueue.global().async { [unowned self] in
      guard let tx = self.txStorage.getTransaction(txHash: txHash) else {
        return
      }
      DispatchQueue.main.async {
        self.output.didReceiveTransaction(tx)
      }
    }
  }

}
