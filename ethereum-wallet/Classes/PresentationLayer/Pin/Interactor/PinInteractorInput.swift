//
//  PinPinInteractorInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol PinInteractorInput: class {
  func getPasscodeInfo()
  func didAddSign(_ sign: String)
  func didDeleteSign()
  func performPostProcess()
}
