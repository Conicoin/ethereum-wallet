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
import RealmSwift
import Alamofire

class SettingsInteractor {
  weak var output: SettingsInteractorOutput!
  
  var keystore: KeystoreServiceProtocol!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
}


// MARK: - SettingsInteractorInput

extension SettingsInteractor: SettingsInteractorInput {
  
  func getWallet() {
    walletDataStoreService.observe { [unowned self] wallet in
      self.output.didReceiveWallet(wallet)
    }
  }
  
  func selectCurrency(_ currency: String) {
    var wallet = walletDataStoreService.getWallet()
    wallet.localCurrency = currency
    walletDataStoreService.save(wallet)
  }
  
  func exportKey(with password: String) {
    do {
      let account = try keystore.getAccount(at: 0)
      let jsonKey = try keystore.jsonKey(for: account, passphrase: password, newPassphrase: password)
      let keyString = String(data: jsonKey, encoding: .utf8)!
      let filename = "conicoin_key.json"
      let path = NSTemporaryDirectory().appending(filename)
      let tempUrl = URL(fileURLWithPath: path)
      try keyString.write(to: tempUrl, atomically: false, encoding: .utf8)
      output.didStoreKey(at: tempUrl)
    } catch let error {
      output.didFailed(with: error)
    }
  }
  
  func deleteTempBackup(at url: URL) {
    do {
      try FileManager.default.removeItem(at: url)
    } catch let error {
      output.didFailed(with: error)
    }
  }
  
  func clearAll(passphrase: String, completion: PinResult?) {
    do {
      // Clear all geth accounts
      try keystore.deleteAllAccounts(passphrase: passphrase)
      
      // Clear keychain
      let keychain = Keychain()
      keychain.deleteAll()
      // Clear defaults
      Defaults.deleteAll()
      // Clear realm
      let realm = try! Realm()
      try! realm.write {
        realm.deleteAll()
      }
      completion?(.success(true))
    } catch {
      completion?(.failure(error))
    }
    
  }

}
