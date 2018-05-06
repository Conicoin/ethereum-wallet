//
//  SendSettingsSendSettingsInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 02/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
