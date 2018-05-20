//
//  ScreenLocker.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import UIKit

class ScreenLocker: ScreenLockerProtocol {
  
  private lazy var lockerView: UIView = {
    let view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = .white
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    imageView.image = R.image.conicoin()
    view.addSubview(imageView)
    imageView.center = view.center
    return view
  }()
  
  func lock() {
    if !lockerView.isDescendant(of: AppDelegate.currentWindow) {
      AppDelegate.currentWindow.addSubview(lockerView)
    }
  }
  
  func unlock() {
    if lockerView.isDescendant(of: AppDelegate.currentWindow) {
      lockerView.removeFromSuperview()
    }
  }

}
