// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

enum ScreenType {
  case iPhone4
  case iPhoneSE
  case iPhone8
  case iPhone8Plus
  case iPhoneX
  case iPhoneXSMax
  case iphoneXR
  
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
    case .iPhoneXSMax:
      return "XSMax"
    case .iphoneXR:
      return "XR"
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
    case 2688:
      return .iPhoneXSMax
    case 1792:
      return .iphoneXR
    default:
      return .iPhone8
    }
  }
}
