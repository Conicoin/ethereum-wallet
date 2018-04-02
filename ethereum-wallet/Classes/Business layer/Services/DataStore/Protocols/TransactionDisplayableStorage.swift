//
//  TransactionDisplayableStorage.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 03/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol TransactionDisplayableStorage {
  func getTransaction(txHash: String) -> TransactionDisplayable?
}
