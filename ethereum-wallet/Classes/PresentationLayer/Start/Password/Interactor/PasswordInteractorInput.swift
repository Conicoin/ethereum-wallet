//
//  PasswordPasswordInteractorInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 20/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation


protocol PasswordInteractorInput: class {
  func createAccount(passphrase: String)
  func restoreAccount(passphrase: String)
  func createWallet(address: String)
}
