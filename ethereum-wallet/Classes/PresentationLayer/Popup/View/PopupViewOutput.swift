// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol PopupViewOutput: class {
  func viewIsReady()
  func didConfirmPressed()
  func didSkipPressed()
}
