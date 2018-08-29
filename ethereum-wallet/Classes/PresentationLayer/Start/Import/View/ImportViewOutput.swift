// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol ImportViewOutput: class {
  func viewIsReady()
  func closeDidPressed()
  func didConfirmKey(_ key: String)
}
