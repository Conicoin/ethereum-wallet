// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

protocol ReceiveInteractorOutput: class {
  func didReceiveWallet(_ wallet: Wallet)
  func didReceiveQRImage(_ image: UIImage)
  func didFailed(with error: Error)
}
