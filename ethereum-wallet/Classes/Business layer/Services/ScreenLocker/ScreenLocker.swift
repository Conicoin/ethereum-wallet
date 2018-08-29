// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
