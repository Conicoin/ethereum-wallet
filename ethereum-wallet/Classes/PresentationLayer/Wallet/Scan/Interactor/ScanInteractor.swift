// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import Foundation


class ScanInteractor {
  weak var output: ScanInteractorOutput!
  
  var qrCaptureService: QRCaptureServiceProtocol!
}


// MARK: - ScanInteractorInput

extension ScanInteractor: ScanInteractorInput {
  
  func startQRCapture() {
    qrCaptureService.start(delegate: output)
  }
  
  func stopQRCapture() {
    qrCaptureService.stop()
  }

}
