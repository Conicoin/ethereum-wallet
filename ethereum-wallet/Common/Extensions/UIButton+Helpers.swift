// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let indicatorTag = 808404
        if show {
            isEnabled = false
            alpha = 0
            let indicator = UIActivityIndicatorView(style: .gray)
            indicator.center = center
            indicator.tag = indicatorTag
            addSubview(indicator)
            indicator.startAnimating()
        } else {
            isEnabled = true
            alpha = 1.0
            if let indicator = viewWithTag(indicatorTag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
