//
//  TransactionDetailsTransactionDetailsRouter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 01/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class TransactionDetailsRouter {

}


// MARK: - TransactionDetailsRouterInput

extension TransactionDetailsRouter: TransactionDetailsRouterInput {
  
  func presentEtherscan(with txHash: String, from: UIViewController) {
    let urlString = Defaults.chain.etherscanUrl + "/tx/\(txHash)"
    guard let url = URL(string: urlString) else { return }
    let svc = SFSafariViewController(url: url)
    from.present(svc, animated: true, completion: nil)
  }
  
}
