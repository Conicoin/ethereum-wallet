//
//  TxIndexDataStoreServiceProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 26/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol TxIndexDataStoreServiceProtocol {
  func observe(updateHandler: @escaping ([TxIndex]) -> Void)
}
