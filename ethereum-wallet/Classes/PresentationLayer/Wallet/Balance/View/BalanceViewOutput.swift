// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol BalanceViewOutput: class {
  func viewIsReady()
  func viewIsAppear()
  func didRefresh()
  func didSelectToken(_ token: Token)
  func didSendPressed()
  func didReceivePressed()
  func didBalanceViewPressed()
}
