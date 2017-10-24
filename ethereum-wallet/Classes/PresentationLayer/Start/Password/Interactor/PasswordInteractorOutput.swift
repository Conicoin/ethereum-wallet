//
//  PasswordPasswordInteractorOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 20/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation


protocol PasswordInteractorOutput: class {
  func didReceive(account: Account)
  func didFailedAccountReceiving(with error: Error)
}
