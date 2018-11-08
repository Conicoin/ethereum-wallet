// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


extension UIRefreshControl {
  func setFallbackTime(_ seconds: TimeInterval) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
      self.endRefreshing()
    }
  }
}
