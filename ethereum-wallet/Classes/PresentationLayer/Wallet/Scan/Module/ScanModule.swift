// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit


class ScanModule {
    
  class func create() -> ScanModuleInput {
    let router = ScanRouter()
    let presenter = ScanPresenter()
    let interactor = ScanInteractor()
    let viewController = R.storyboard.scan.scanViewController()!

    interactor.output = presenter
    interactor.qrCaptureService = QRCaptureService()

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
        
    return presenter
  }
    
}
