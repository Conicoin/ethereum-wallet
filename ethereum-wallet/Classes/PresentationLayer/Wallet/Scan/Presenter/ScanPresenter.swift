// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



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
    
  func dismiss() {
    view.dissmissModal()
  }
    
}


// MARK: - ScanViewOutput

extension ScanPresenter: ScanViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    interactor.startQRCapture()
  }
  
  func didCancelPressed() {
    dismiss()
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
  
  func qrCaptureDidDetect(object: AVMetadataMachineReadableCodeObject) {
    guard let code = object.stringValue else {
      return
    }
    output?.didDetectQRCode(code)
    dismiss()
  }
  
}


// MARK: - ScanModuleInput

extension ScanPresenter: ScanModuleInput {
  
  func present(from: UIViewController, output: ScanModuleOutput) {
    self.output = output
    view.presentModal(fromViewController: from)
  }

}
