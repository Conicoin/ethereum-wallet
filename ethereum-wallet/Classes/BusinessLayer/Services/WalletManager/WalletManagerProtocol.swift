// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

protocol WalletManagerProtocol {
  func createWallet(passphrase: String) throws
  func importWallet(jsonKey: Data, passphrase: String) throws
  func importWallet(privateKey: Data, passphrase: String) throws
  func importWallet(mnemonic: [String], passphrase: String) throws
}
