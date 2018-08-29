// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


protocol PinInteractorOutput: class {
  func didReceivePinInfo(_ info: PinInfo)
  func didFailedPostProcess(with error: Error)
  func didPreformPostProccess()
}
