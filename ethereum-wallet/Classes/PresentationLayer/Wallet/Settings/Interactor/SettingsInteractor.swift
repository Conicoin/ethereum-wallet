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
      
      // Cancel all requests
      SessionManager.default.session.getAllTasks { tasks in
        tasks.forEach { $0.cancel() }
      }
      
      completion?(.success(true))
    } catch {
      completion?(.failure(error))
    }
  }
    
  func changePin(oldPin: String, newPin: String, completion: PinResult?) {
    do {
      let keychain = Keychain()
      let key = try keychain.getJsonKey()
      let newKey = try keystore.changePassphrase(oldPin, new: newPin, key: key)
      keychain.jsonKey = newKey
      completion?(.success(true))
    } catch {
      completion?(.failure(error))
    }
  }
  
  func getExportKeyUrl(passcode: String) {
    do {
      guard let keyUrl = try FileManager.default.contentsOfDirectory(atPath: keystore.keystoreUrl).first else {
        throw KeystoreError.noJsonKey
      }
      
      let url = URL(fileURLWithPath: keystore.keystoreUrl + "/" + keyUrl)
      
      let timestamp = Int(Date().timeIntervalSince1970)
      let filename = "conicoin_key_\(timestamp).json"
      let path = NSTemporaryDirectory().appending(filename)
      let tempUrl = URL(fileURLWithPath: path)
      
      let data = try Data(contentsOf: url)
      try data.write(to: tempUrl)
      
      output.didReceiveExportKeyUrl(tempUrl)
    } catch {
      output.didFailed(with: error)
    }
  }
  
}
