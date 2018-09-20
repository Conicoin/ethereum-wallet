// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import AVFoundation


protocol ScanInteractorOutput: QRCaptureServiceDelegate {
  func qrCaptureDidStart(session: AVCaptureSession)
  func qrCaptureDidFailed(with error: Error)
  func qrCaptureDidDetect(object: AVMetadataMachineReadableCodeObject)
}
