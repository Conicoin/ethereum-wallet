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


import UIKit


class ReceivePresenter {
    
  weak var view: ReceiveViewInput!
  weak var output: ReceiveModuleOutput?
  var interactor: ReceiveInteractorInput!
  var router: ReceiveRouterInput!
  
  // TODO: Use Coin for BIP21
  var coin: CoinDisplayable!
}


// MARK: - ReceiveViewOutput

extension ReceivePresenter: ReceiveViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveCoin(coin)
    interactor.getWallet()
  }
  
  func copyAddressPressed(address: String) {
    UIPasteboard.general.string = address
    view.popToRoot()
    view.viewController.showAlert(title: Localized.receiveAlertCopy(), message: nil)
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

  func presentSend(for coin: Coin, from: UIViewController) {
    self.coin = coin
    view.present(fromViewController: from)
  }
  
  func presentSend(for token: Token, from: UIViewController) {
    self.coin = token
    view.present(fromViewController: from)
  }
  
}
