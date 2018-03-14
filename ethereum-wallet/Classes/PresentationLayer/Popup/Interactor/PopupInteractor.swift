//
//  PopupPopupInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


class PopupInteractor {
  weak var output: PopupInteractorOutput!
  var postProcess: PopupPostProcessProtocol!
}


// MARK: - PopupInteractorInput

extension PopupInteractor: PopupInteractorInput {
  
  func executePostProcess() {
    postProcess.onConfirm { [unowned self] result in
      switch result {
      case .success:
        self.output.postProcessDidSucced()
      case .failure(let error):
        self.output.didFailed(with: error)
      }
    }
  }

}
