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
}

extension UIDevice {
  var iPhone: Bool {
    return UIDevice().userInterfaceIdiom == .phone
  }
  
  var screenType: ScreenType? {
    guard iPhone else { return nil }
    switch UIScreen.main.nativeBounds.height {
    case 960:
      return .iPhone4
    case 1136:
      return .iPhoneSE
    case 1334:
      return .iPhone8
    case 2208:
      return .iPhone8Plus
    default:
      return .iPhoneX
    }
  }
}
