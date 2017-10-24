//
//  TransactionsDataStoreServiceProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

protocol TransactionsDataStoreServiceProtocol {
  func getTransactions() -> [Transaction]
  func saveTransactions(_ transactions: [Transaction])
  func observe(updateHandler: @escaping ([Transaction]) -> Void)
}
