// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol ImportInteractorInput: class {
  func verifyKey(_ key: String)
  func importKey(_ key: WalletKey, passcode: String, completion: PinResult?)
}
