// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit
import AVFoundation

protocol ScanViewInput: class, Presentable {
  func setupInitialState()
  func didStartCapture(session: AVCaptureSession)
}
