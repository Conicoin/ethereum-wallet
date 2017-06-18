//
//  UIBarButtonItem+Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let indicatorTag = 808404
        if show {
            isEnabled = false
            alpha = 0
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            indicator.center = center
            indicator.tag = indicatorTag
            superview?.addSubview(indicator)
            indicator.startAnimating()
        } else {
            isEnabled = true
            alpha = 1.0
            if let indicator = superview?.viewWithTag(indicatorTag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
