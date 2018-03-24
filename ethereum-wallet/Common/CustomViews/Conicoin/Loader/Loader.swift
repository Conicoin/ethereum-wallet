//
//  Loader.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 23/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class Loader {
  
  private static var tag = 1441

  static func start() {
    let frame = CGRect(x: 0, y: 0, width: 56, height: 56)
    let loader = LoaderView(frame: frame, type: .loading)
    let view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    view.tag = tag
    loader.center = view.center
    view.addSubview(loader)
    UIApplication.shared.keyWindow?.addSubview(view)
  }
  
  static func stop() {
    guard let loader = UIApplication.shared.keyWindow?.viewWithTag(tag) else {
      return
    }
    loader.removeFromSuperview()
  }
  
}
