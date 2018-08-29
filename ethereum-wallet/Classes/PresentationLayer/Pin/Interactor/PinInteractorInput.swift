// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


protocol PinInteractorInput: class {
  func getPinInfo()
  func addSign(_ sign: String)
  func deleteSign()
  func authenticateWithBiometrics()
}
