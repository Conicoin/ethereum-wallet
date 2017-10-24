//
//  PasswordPasswordViewOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 20/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol PasswordViewOutput: class {
  func viewIsReady()
  func didConfirmPassword(_ password: String)
}
