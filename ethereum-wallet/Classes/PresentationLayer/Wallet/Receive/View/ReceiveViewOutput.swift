// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol ReceiveViewOutput: class {
  func viewIsReady()
  func copyAddressPressed(address: String)
}
