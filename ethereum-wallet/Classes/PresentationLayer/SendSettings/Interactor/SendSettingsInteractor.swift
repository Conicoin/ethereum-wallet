// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


class SendSettingsInteractor {
  weak var output: SendSettingsInteractorOutput!
  
  var walletRepository: WalletRepository!
}


// MARK: - SendSettingsInteractorInput

extension SendSettingsInteractor: SendSettingsInteractorInput {
  
  func getWallet() {
    let wallet = walletRepository.wallet
    output.didReceiveWallet(wallet)
  }

}
