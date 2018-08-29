// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
