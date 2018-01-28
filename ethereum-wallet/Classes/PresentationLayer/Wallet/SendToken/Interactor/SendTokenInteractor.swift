//
//  SendTokenSendTokenInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


class SendTokenInteractor {
  weak var output: SendTokenInteractorOutput!
  
  var coinDataStoreService: CoinDataStoreServiceProtocol!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var transactionsDataStoreService: TransactionsDataStoreServiceProtocol!
  var transactionService: TransactionServiceProtocol!
  var gasService: GasServiceProtocol!
}


// MARK: - SendTokenInteractorInput

extension SendTokenInteractor: SendTokenInteractorInput {
  
  func getCheckout(iso: String, fee: Decimal) {
    do {
      guard
        let coin = coinDataStoreService.find(withIso: "ETH"),
        let rate = coin.rates.first(where: { $0.to == iso }) else {
        throw SendCheckoutError.noRate
      }
      let ethFee = Ether(fee)
      let fiatFee = ethFee.amount(in: iso, rate: rate.value)
      output.didReceiveCheckout(ethFee: ethFee.amount, fiatFee: fiatFee)
    } catch let error {
      output.didFailed(with: error)
    }
  }
  
  func getWallet() {
    let wallet = walletDataStoreService.getWallet()
    output.didReceiveWallet(wallet)
  }
  
  func sendTransaction(for token: Token, amount: Decimal, to: String, gasLimit: Decimal) {
    do {
      let keychain = Keychain()
      let passphrase = try keychain.getPassphrase()
      let info = TransactionInfo(amount: amount, address: to, contractAddress: token.address, gasLimit: gasLimit)
      transactionService.sendTransaction(with: info, passphrase: passphrase) { [weak self] result in
        guard let `self` = self else { return }
        switch result {
        case .success(let sendedTransaction):
          var transaction = Transaction.mapFromGethTransaction(sendedTransaction, time: Date().timeIntervalSince1970)
          transaction.isPending = true
          transaction.isIncoming = false
          self.transactionsDataStoreService.save(transaction)
          self.output.didSendTransaction()
        case .failure(let error):
          self.output.didFailedSending(with: error)
        }
      }
    } catch {
      output.didFailedSending(with: error)
    }
  }
  
  func getGasPrice() {
    gasService.getSuggestedGasPrice() { [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success(let gasPrice):
        self.output.didReceiveGasPrice(Decimal(gasPrice))
      case .failure(let error):
        self.output.didFailed(with: error)
      }
    }
  }
  
  func getGasLimit() {
    gasService.getSuggestedGasLimit() { [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success(let gasLimit):
        self.output.didReceiveGasLimit(Decimal(gasLimit))
      case .failure(let error):
        self.output.didFailed(with: error)
      }
    }
  }

}
