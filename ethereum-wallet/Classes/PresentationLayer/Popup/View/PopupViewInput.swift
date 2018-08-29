// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol PopupViewInput: class, Presentable {
  func setupInitialState()
  func setState(_ state: PopupStateProtocol)
}
