//
//  WalletManagerProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol WalletManagerProtocol {
  func createWallet(passphrase: String) throws
  func importWallet(jsonKey: Data, passphrase: String) throws
  func importWallet(privateKey: Data, passphrase: String) throws
  func importWallet(mnemonic: [String], passphrase: String) throws
}
