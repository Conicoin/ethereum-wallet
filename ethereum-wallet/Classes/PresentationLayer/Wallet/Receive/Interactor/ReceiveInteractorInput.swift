// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import CoreGraphics

protocol ReceiveInteractorInput: class {
  func getWallet()
  func getQrImage(from string: String, size: CGSize)
}
