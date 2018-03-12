//
//  PinPinViewInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol PinViewInput: class, Presentable {
  func setupInitialState()
  func didSucceed()
  func didFailed()
  func didChangeState()
  func didAddSignAtIndex(_ index: Int)
  func didRemoveSignAtIndex(_ index: Int)
  func didReceivePasscodeInfo(_ info: PasscodeInfo)
}
