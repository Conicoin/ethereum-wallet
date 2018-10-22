//
//  UIRefreshControl+Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


extension UIRefreshControl {
  func setFallbackTime(_ seconds: TimeInterval) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
      self.endRefreshing()
    }
  }
}
