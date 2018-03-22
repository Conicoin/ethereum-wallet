//
//  PinEnterPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PinEnterPostProcess: PinPostProcessProtocol {
  
  let completion: (String) -> Void
  
  init(completion: @escaping (String) -> Void) {
    self.completion = completion
  }
  
  func perform(with passphrase: String) throws {
    completion(passphrase)
  }
  
}
