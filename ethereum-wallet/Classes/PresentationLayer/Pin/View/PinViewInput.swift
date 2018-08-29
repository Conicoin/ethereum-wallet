// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol PinViewInput: class, Presentable {
  func setupInitialState()
  func didSucceed()
  func didFailed()
  func didChangeState()
  func didAddSignAtIndex(_ index: Int)
  func didRemoveSignAtIndex(_ index: Int)
  func didReceivePinInfo(_ info: PinInfo)
}
