//
//  PinPinInteractorOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol PinInteractorOutput: class {
  func didReceivePasscodeInfo(_ info: PasscodeInfo)
  func didFailedPostProcess(with error: Error)
  func didPreformPostProccess()
}
