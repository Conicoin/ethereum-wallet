//
//  TokenDataStoreServiceProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

protocol TokenDataStoreServiceProtocol {
  func find() -> [Token]
  func save(_ models: [Token])
  func observe(updateHandler: @escaping ([Token]) -> Void)
}
