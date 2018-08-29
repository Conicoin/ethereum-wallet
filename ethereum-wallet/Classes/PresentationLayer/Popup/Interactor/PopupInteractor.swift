// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
