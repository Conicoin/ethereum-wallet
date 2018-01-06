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

protocol KeystoreServiceProtocol {
  func getAccount(at index: Int) throws -> GethAccount
  func createAccount(passphrase: String) throws -> GethAccount
  func jsonKey(for account: GethAccount, passphrase: String) throws -> Data
  func jsonKey(for account: GethAccount, passphrase: String, newPassphrase: String) throws -> Data
  func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount
  func deleteAccount(_ account: GethAccount, passphrase: String) throws
  func deleteAllAccounts(passphrase: String) throws
  func signTransaction(_ transaction: GethTransaction, account: GethAccount, passphrase: String, chainId: Int64) throws -> GethTransaction
}
