//
//  WalletDataStoreServiceProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

protocol WalletDataStoreServiceProtocol {
  func createWallet(address: String)
  func getWallet() -> Wallet
}
