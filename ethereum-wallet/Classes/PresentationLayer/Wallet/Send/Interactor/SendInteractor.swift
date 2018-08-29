// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


class SendInteractor {
  weak var output: SendInteractorOutput!
  
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var transactionsDataStoreService: TransactionsDataStoreServiceProtocol!
  var transactionService: TransactionServiceProtocol!
  var gasService: GasServiceProtocol!
  var checkoutService: SendCheckoutServiceProtocol!
}


// MARK: - SendInteractorInput

extension SendInteractor: SendInteractorInput {
  
  func getCheckout(for coin: CoinDisplayable, amount: Decimal, iso: String, fee: Decimal) {
    do {
      let checkout = try checkoutService.checkout(for: coin, amount: amount, iso: iso, fee: fee)
      output.didReceiveCheckout(amount: checkout.amount, total: checkout.total, fiatAmount: checkout.fiatAmount, fee: checkout.fee)
    } catch let error {
      output.didFailed(with: error)
    }
  }
  
  func getWallet() {
    walletDataStoreService.getWallet(queue: .main) { wallet in
      self.output.didReceiveWallet(wallet)
    }
  }
  
  func sendTransaction(coin: CoinDisplayable, amount: Decimal, to: String, settings: SendSettings, pin: String, pinResult: PinResult?) {

    let info = TransactionInfo(amount: amount, address: to, contractAddress: coin.contract, decimals: coin.decimals, settings: settings)
    
    transactionService.sendTransaction(with: info, passphrase: pin) { [unowned self] result in
      switch result {
      case .success(let sendedTransaction):
        
        self.walletDataStoreService.getWallet(queue: .global()) { wallet in
          let builder = PendingTxBuilder()
          var transaction = builder.build(sendedTransaction, from: wallet.address, time: Date(), txMeta: coin.tokenMeta)
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
