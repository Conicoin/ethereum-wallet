// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


class ImportInteractor {
  weak var output: ImportInteractorOutput!
  
  var keychain: Keychain!
  var keystore: KeystoreServiceProtocol!
  var verificator: ImportVerificatorProtocol!
  var walletManager: WalletManagerProtocol!
}


// MARK: - ImportInteractorInput

extension ImportInteractor: ImportInteractorInput {
  
  func verifyKey(_ key: String) {
    verificator.verifyKey(key) { result in
      switch result {
      case .success(let key):
        output.didConfirmValidKey(key)
      case .failure(let error):
        output.didFailed(with: error)
      }
    }
  }
  
  func importKey(_ key: WalletKey, passcode: String, completion: PinResult?) {
    DispatchQueue.global().async { [unowned self] in
      do {
        
        try self.keystore.deleteAllAccounts(passphrase: passcode)
       
        switch key {
        case .jsonKey(let jsonKey):
          try self.walletManager.importWallet(jsonKey: jsonKey, passphrase: passcode)
        case .privateKey(let privateKey):
          try self.walletManager.importWallet(privateKey: privateKey, passphrase: passcode)
        case .mnemonic(let mnemonic):
          try self.walletManager.importWallet(mnemonic: mnemonic, passphrase: passcode)
          self.keychain.isHdWalletBackuped = true
        }
        
        DispatchQueue.main.async {
          completion?(.success(true))
        }
      } catch {
        DispatchQueue.main.async {
          completion?(.failure(error))
        }
      }
    }
    
  }
  
}

