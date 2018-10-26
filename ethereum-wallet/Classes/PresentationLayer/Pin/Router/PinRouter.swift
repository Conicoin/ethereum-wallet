// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation
import UIKit
import SafariServices


class PinRouter {
  var app: Application!
}


// MARK: - PinRouterInput

extension PinRouter: PinRouterInput {
    
    func presentPrivacyPolicy(from: UIViewController) {
        let urlString = Constants.Conicoin.privacyUrl
        guard let url = URL(string: urlString) else { return }
        let svc = SFSafariViewController(url: url)
        from.present(svc, animated: true, completion: nil)
    }
    
}
