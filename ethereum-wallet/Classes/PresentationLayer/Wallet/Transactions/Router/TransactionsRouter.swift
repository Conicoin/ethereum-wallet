// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import UIKit

class TransactionsRouter {
  var app: Application!
}


// MARK: - TransactionsRouterInput

extension TransactionsRouter: TransactionsRouterInput {
  
  func presentDetails(with txIndex: TransactionDisplayer, from: UIViewController) {
    TransactionDetailsModule.create(app: app, isToken: txIndex.isTokenTransfer).present(with: txIndex, from: from)
  }
  
}
