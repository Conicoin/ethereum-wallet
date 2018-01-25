//
//  TransactionFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Geth

protocol TransactionFactoryProtocol {
  func buildTransaction(with info: TransactionInfo, type: TransferType) throws -> GethTransaction
}
