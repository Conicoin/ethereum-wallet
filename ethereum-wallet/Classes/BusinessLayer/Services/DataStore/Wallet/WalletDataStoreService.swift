// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import RealmSwift

class WalletDataStoreService: RealmStorable<Wallet>, WalletDataStoreServiceProtocol {
  
  typealias PlainType = Wallet
  
  func createWallet(address: String) {
    let wallet = Wallet(address: address.lowercased(), localCurrency: Constants.Wallet.defaultCurrency)
    save(wallet)
  }
  
  func getWallet() -> Wallet {
    return find().first!
  }
  
  func observe(updateHandler: @escaping (Wallet) -> Void) {
    super.observe { (wallets) in
      guard let wallet = wallets.first else { return }
      updateHandler(wallet)
    }
  }

}
