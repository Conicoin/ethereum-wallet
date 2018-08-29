// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import CoreGraphics

class ReceiveInteractor {
  weak var output: ReceiveInteractorOutput!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var qrService: QRServiceProtocol!
}


// MARK: - ReceiveInteractorInput

extension ReceiveInteractor: ReceiveInteractorInput {
  
  func getWallet() {
    walletDataStoreService.getWallet(queue: .main) { wallet in
      self.output.didReceiveWallet(wallet)
    }
  }
  
  func getQrImage(from string: String, size: CGSize) {
    do {
      let image = try qrService.createQR(fromString: string, size: size)
      output.didReceiveQRImage(image)
    } catch {
      output.didFailed(with: error)
    }
  }

}
