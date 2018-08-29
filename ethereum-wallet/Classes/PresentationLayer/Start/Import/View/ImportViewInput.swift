// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol ImportViewInput: class, Presentable {
  func setupInitialState()
  func setState(_ state: ImportStateProtocol)
}
