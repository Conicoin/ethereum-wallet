// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

enum ScreenType {
  case iPhone4
  case iPhoneSE
  case iPhone8
  case iPhone8Plus
  case iPhoneX
  
  var prefix: String {
    switch self {
    case .iPhone4:
      return "4"
    case .iPhoneSE:
      return "SE"
    case .iPhone8:
      return ""
    case .iPhone8Plus:
      return "8P"
    case .iPhoneX:
      return "X"
    }
  }
  
}

extension UIDevice {
  static var iPhone: Bool {
    return UIDevice().userInterfaceIdiom == .phone
  }
  
  static var screenType: ScreenType {
    switch UIScreen.main.nativeBounds.height {
    case 960:
      return .iPhone4
    case 1136:
      return .iPhoneSE
    case 1334:
      return .iPhone8
    case 2208:
      return .iPhone8Plus
    case 2436:
      return .iPhoneX
    default:
      return .iPhone8
    }
  }
}
