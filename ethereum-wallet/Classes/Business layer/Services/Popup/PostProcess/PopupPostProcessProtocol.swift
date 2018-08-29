// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

protocol PopupPostProcessProtocol {
  typealias PopupPostProcessCallback = (Result<Bool>) -> Void
    
  func onConfirm(_ completion: @escaping PopupPostProcessCallback)
}
