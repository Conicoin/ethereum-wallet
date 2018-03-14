//
//  PopupPostProcessProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import Alamofire

protocol PopupPostProcessProtocol {
  func onConfirm(_ completion: (Result<Bool>) -> Void)
}
