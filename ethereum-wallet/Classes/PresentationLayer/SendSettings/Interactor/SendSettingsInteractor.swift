// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


class SendSettingsInteractor {
  weak var output: SendSettingsInteractorOutput!
  
  var walletDataStoreService: WalletDataStoreServiceProtocol!
}


// MARK: - SendSettingsInteractorInput

extension SendSettingsInteractor: SendSettingsInteractorInput {
  
  func getWallet() {
    walletDataStoreService.getWallet(queue: .main) { [unowned self] wallet in
      self.output.didReceiveWallet(wallet)
    }
  }

}
