// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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



import UIKit
import AVFoundation

class ScanPresenter {
    
  weak var view: ScanViewInput!
  weak var output: ScanModuleOutput?
  var interactor: ScanInteractorInput!
  var router: ScanRouterInput!
  
  deinit {
    interactor.stopQRCapture()
  }
    
}


// MARK: - ScanViewOutput

extension ScanPresenter: ScanViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    interactor.startQRCapture()
  }

}


// MARK: - ScanInteractorOutput

extension ScanPresenter: ScanInteractorOutput {
  
  func qrCaptureDidStart(session: AVCaptureSession) {
    view.didStartCapture(session: session)
  }
  
  func qrCaptureDidFailed(with error: Error) {
    output?.didFailedQRCapture(with: error)
    view.dissmiss()
  }
  
  func qrCaptureDidDetect(object: AVMetadataMachineReadableCodeObject?) {
    guard let code = object?.stringValue else {
      return
    }
    output?.didDetectQRCode(code)
    view.dissmiss()
  }
  
}


// MARK: - ScanModuleInput

extension ScanPresenter: ScanModuleInput {
  
  func present(from: UIViewController, output: ScanModuleOutput) {
    self.output = output
    view.present(fromViewController: from)
  }

}
