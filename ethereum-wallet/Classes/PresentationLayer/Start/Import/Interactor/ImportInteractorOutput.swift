// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol ImportInteractorOutput: class {
  func didConfirmValidKey(_ key: WalletKey)
  func didFailed(with error: Error)
}
