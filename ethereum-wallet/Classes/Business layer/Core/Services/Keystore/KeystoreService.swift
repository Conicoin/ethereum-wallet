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


import Geth

class KeystoreService: KeystoreServiceProtocol {
  
  private lazy var keystore: GethKeyStore! = {
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    return GethNewKeyStore(documentDirectory + "/keystore", GethLightScryptN, GethLightScryptP)
  }()
  
  // MARK: Account managment
  
  func getAccount(at index: Int) throws -> GethAccount {
    return try keystore.getAccounts().get(index)
  }
  
  func createAccount(passphrase: String) throws -> GethAccount {
    guard keystore.getAccounts().size() == 0 else {
      throw EthereumError.accountExist
    }
    
    return try keystore.newAccount(passphrase)
  }
  
  func jsonKey(for account: GethAccount, passphrase: String) throws -> Data {
    return try keystore.exportKey(account, passphrase: passphrase, newPassphrase: passphrase)
  }
  
  func jsonKey(for account: GethAccount, passphrase: String, newPassphrase: String) throws -> Data {
    return try keystore.exportKey(account, passphrase: passphrase, newPassphrase: newPassphrase)
  }
  
  func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount  {
    return try keystore.importKey(jsonKey, passphrase: passphrase, newPassphrase: passphrase)
  }
  
  func deleteAccount(_ account: GethAccount, passphrase: String) throws {
    return try keystore.delete(account, passphrase: passphrase)
  }
  
  func deleteAllAccounts(passphrase: String) throws {
    let size = keystore.getAccounts().size()
    for i in 0..<size {
      let account = try getAccount(at: i)
      try keystore.delete(account, passphrase: passphrase)
    }
  }
  
  // MARK: Sign transaction
  
  func signTransaction(_ transaction: GethTransaction, account: GethAccount, passphrase: String, chainId: Int64) throws -> GethTransaction {
    let bigChainId = GethBigInt(chainId)
    return try keystore.signTxPassphrase(account, passphrase: passphrase, tx: transaction, chainID: bigChainId)
  }
  
}
