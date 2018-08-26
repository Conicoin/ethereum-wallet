// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


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
