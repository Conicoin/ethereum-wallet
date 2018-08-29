// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol WelcomeInteractorInput: class {
  func createWallet(passcode: String, completion: PinResult?)
  func importPrivateKey(_ key: String, passcode: String, completion: PinResult?)
  func importMnemonic(_ mnemonic: String, passcode: String, completion: PinResult?)
}
