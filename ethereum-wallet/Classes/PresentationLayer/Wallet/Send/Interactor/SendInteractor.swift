// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


class SendInteractor {
  weak var output: SendInteractorOutput!
  
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var transactionsDataStoreService: TransactionsDataStoreServiceProtocol!
  var transactionService: TransactionServiceProtocol!
  var gasService: GasServiceProtocol!
  var pendingTxBuilder: PendingTxBuilder!
}


// MARK: - SendInteractorInput

extension SendInteractor: SendInteractorInput {
  
  func getWallet() {
    walletDataStoreService.getWallet(queue: .main) { wallet in
      self.output.didReceiveWallet(wallet)
    }
  }
  
  func sendTransaction(amount: Decimal, to: String, settings: SendSettings, pin: String, pinResult: PinResult?) {

    let info = TransactionInfo(amount: amount, address: to, settings: settings)
    transactionService.sendTransaction(with: info, passphrase: pin) { [unowned self] result in
      switch result {
      case .success(let sendedTransaction):
        
        self.walletDataStoreService.getWallet(queue: .global()) { wallet in
          var transaction = self.pendingTxBuilder.build(sendedTransaction, from: wallet.address, time: Date())
          transaction.isPending = true
          transaction.isIncoming = false
          self.transactionsDataStoreService.save(transaction)
          DispatchQueue.main.async {
            pinResult?(.success(true))
          }
        }
        
      case .failure(let error):
        pinResult?(.failure(error))
        self.output.didFailedSending(with: error)
      }
    }
  }
  
  func getGasPrice() {
    gasService.getSuggestedGasPrice() { [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success(let gasPrice):
        self.output.didReceiveGasPrice(gasPrice)
      case .failure(let error):
        self.output.didFailed(with: error)
      }
    }
  }
  
  func getGasLimit(from: String, to: String, amount: Decimal, settings: SendSettings) {
    gasService.getSuggestedGasLimit(from: from, to: to, amount: amount, settings: settings) { [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success(let gasLimit):
        self.output.didReceiveGasLimit(gasLimit)
      case .failure(let error):
        self.output.didFailed(with: error)
      }
    }
  }
  
}
