// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class ReceivePresenter {
    
  weak var view: ReceiveViewInput!
  weak var output: ReceiveModuleOutput?
  var interactor: ReceiveInteractorInput!
  var router: ReceiveRouterInput!
}


// MARK: - ReceiveViewOutput

extension ReceivePresenter: ReceiveViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    interactor.getWallet()
  }
  
  func copyAddressPressed(address: String) {
    UIPasteboard.general.string = address
    view.viewController.showAlert(title: Localized.receiveAlertCopy(), message: nil) { [unowned self] _ in
      self.view.popToRoot()
    }
  }

}


// MARK: - ReceiveInteractorOutput

extension ReceivePresenter: ReceiveInteractorOutput {
  
  func didReceiveQRImage(_ image: UIImage) {
    view.didReceiveQRImage(image)
  }
  
  func didReceiveWallet(_ wallet: Wallet) {
    view.didReceiveWallet(wallet)
    interactor.getQrImage(from: wallet.address, size: CGSize(width: 300, height: 300))
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }
  
}


// MARK: - ReceiveModuleInput

extension ReceivePresenter: ReceiveModuleInput {

  func presentSend(from: UIViewController) {
    view.present(fromViewController: from)
  }
}
