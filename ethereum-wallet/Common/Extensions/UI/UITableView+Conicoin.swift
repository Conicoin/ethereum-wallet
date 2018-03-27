//
//  UITableView+Conicoin.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 27/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit
import SpringIndicator

extension UITableView {
  
  func setupRefresh(target: Any, selector: Selector) -> RefreshIndicator {
    let refreshControl = RefreshIndicator()
    refreshControl.indicator.lineColor = Theme.Color.blue
    refreshControl.indicator.lineWidth = 2.4
    refreshControl.indicator.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    refreshControl.indicator.rotationDuration = 2
    refreshControl.addTarget(target, action: selector, for: .valueChanged)
    insertSubview(refreshControl, at: 0)
    return refreshControl
  }

}
