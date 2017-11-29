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


class SendInteractor {
  weak var output: SendInteractorOutput!
  
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var coinDataStoreService: CoinDataStoreServiceProtocol!
  var ethereumService: EthereumCoreProtocol!
}


// MARK: - SendInteractorInput

extension SendInteractor: SendInteractorInput {
  
  func getWallet() {
    let wallet = walletDataStoreService.getWallet()
    output.didReceiveWallet(wallet)
  }
  
  func getCoin() {
    guard let coin = coinDataStoreService.find().first else {
      output.didFailed(with: SendError.coinNotFound)
      return
    }
    output.didReceiveCoin(coin)
  }
  
  func sendTransaction(amount: Decimal, to: String, gasLimit: Decimal) {
    do {
      let keychain = Keychain()
      let passphrase = try keychain.getPassphrase()
      try ethereumService.sendTransaction(amountHex: amount.toHex(), to: to, gasLimitHex: gasLimit.toHex(), passphrase: passphrase)
      output.didSendTransaction()
    } catch {
      output.didFailed(with: error)
    }
  }
  
  func getGasPrice() {
    do {
      let gasPrice = try ethereumService.getSuggestedGasPrice()
      output.didReceiveGasPrice(Decimal(gasPrice))
    } catch {
      output.didFailed(with: error)
    }
  }
  
  func getGasLimit() {
    do {
      let gasLimit = try ethereumService.getSuggestedGasLimit()
      output.didReceiveGasLimit(Decimal(gasLimit))
    } catch {
      output.didFailed(with: error)
    }
  }

}
