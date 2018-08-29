// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import Foundation


protocol SettingsInteractorOutput: class {
  func didReceiveWallet(_ wallet: Wallet)
  func didFailed(with error: Error)
  func didFailedRegisterForRemoteNotification()
  func didReceiveExportKeyUrl(_ url: URL)
}
