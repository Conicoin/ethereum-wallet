//
//  Loader.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 23/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit
import SpringIndicator

class Loader {
  
  private static var tag = 1441

  static func start() {
    let view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    view.tag = tag
    let indicator = SpringIndicator(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
    indicator.lineColor = Theme.Color.blue
    indicator.lineWidth = 2.4
    indicator.rotationDuration = 2
    view.addSubview(indicator)
    indicator.center = view.center
    indicator.start()
    UIApplication.shared.keyWindow?.addSubview(view)
  }
  
  static func stop() {
    guard let loader = UIApplication.shared.keyWindow?.viewWithTag(tag) else {
      return
    }
    UIView.animate(withDuration: 0.4, animations: {
      loader.alpha = 0
    }) { _ in
      loader.removeFromSuperview()
    }
  }
  
}
