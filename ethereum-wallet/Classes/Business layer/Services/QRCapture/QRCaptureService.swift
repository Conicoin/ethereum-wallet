// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.



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
