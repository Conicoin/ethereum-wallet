// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import Foundation


protocol ScanModuleOutput: class {
  func didDetectQRCode(_ code: String)
  func didFailedQRCapture(with error: Error)
}
