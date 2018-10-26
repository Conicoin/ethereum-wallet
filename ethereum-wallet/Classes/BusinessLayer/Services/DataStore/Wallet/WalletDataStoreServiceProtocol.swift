// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

protocol WalletDataStoreServiceProtocol {
  func createWallet(address: String)
  func getWallet(queue: DispatchQueue, completion: @escaping (Wallet) -> Void)
  func getWallet() -> Wallet
  func observe(updateHandler: @escaping (Wallet) -> Void)
  func find() -> [Wallet]
  func save(_ model: Wallet)
}
