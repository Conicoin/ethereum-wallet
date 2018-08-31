// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import AVFoundation

protocol QRCaptureServiceDelegate: class {
  func qrCaptureDidStart(session: AVCaptureSession)
  func qrCaptureDidFailed(with error: Error)
  func qrCaptureDidDetect(object: AVMetadataMachineReadableCodeObject)
}

class QRCaptureService: NSObject, QRCaptureServiceProtocol {
  
  weak var delegate: QRCaptureServiceDelegate?
  
  private var captureSession: AVCaptureSession?
  
  func start(delegate: QRCaptureServiceDelegate?) {
    
    self.delegate = delegate
    
    let captureDevice = AVCaptureDevice.default(for: .video)!
    
    do {
      let input = try AVCaptureDeviceInput(device: captureDevice)
      captureSession = AVCaptureSession()
      captureSession?.addInput(input)
      
      let captureMetadataOutput = AVCaptureMetadataOutput()
      captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      captureSession?.addOutput(captureMetadataOutput)
      captureMetadataOutput.metadataObjectTypes = [.qr]
      
      captureSession?.startRunning()
      delegate?.qrCaptureDidStart(session: captureSession!)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func stop() {
    captureSession?.stopRunning()
  }
  
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension QRCaptureService: AVCaptureMetadataOutputObjectsDelegate {
  
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
      guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
        metadataObject.type == .qr else {
          return
      }
      stop()
      delegate?.qrCaptureDidDetect(object: metadataObject)
  }
  
}
