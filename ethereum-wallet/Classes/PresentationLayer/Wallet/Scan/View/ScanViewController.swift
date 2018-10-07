// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit
import AVFoundation

class ScanViewController: UIViewController {
  @IBOutlet var cancelButton: UIButton!
  
  var output: ScanViewOutput!

  private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
  
  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
    localize()
  }
  
  func localize() {
    cancelButton.setTitle(Localized.commonCancel(), for: .normal)
  }
  
  // MARK: Actions

  @IBAction func cancelPressed(_ sender: UIButton) {
    output.didCancelPressed()
  }
}


// MARK: - ScanViewInput

extension ScanViewController: ScanViewInput {
    
  func setupInitialState() {

  }
  
  func didStartCapture(session: AVCaptureSession) {
    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
    videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
    videoPreviewLayer?.frame = view.layer.bounds
    view.layer.addSublayer(videoPreviewLayer!)
    view.bringSubviewToFront(cancelButton)
  }

}
