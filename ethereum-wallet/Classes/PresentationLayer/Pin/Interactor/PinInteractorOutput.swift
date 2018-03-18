//
//  PinPinInteractorOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol PinInteractorOutput: class {
  func didReceivePinInfo(_ info: PinInfo)
  func didFailedPostProcess(with error: Error)
  func didPreformPostProccess()
}
