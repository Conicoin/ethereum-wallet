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
    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//      pinResult?(.success(true))
//    }
    
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
