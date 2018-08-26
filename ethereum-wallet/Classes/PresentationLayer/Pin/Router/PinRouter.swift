//
//  PinPinRouter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import UIKit
import SafariServices


class PinRouter {

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
