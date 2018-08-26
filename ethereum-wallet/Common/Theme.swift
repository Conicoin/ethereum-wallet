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

struct Theme {
  
  struct Color {
    
    /* @IBInspectable don't work with colors assets */
    #if TARGET_INTERFACE_BUILDER
    
    static let black = UIColor.black
    static let blue = UIColor.blue
    static let gray = UIColor.gray
    static let green = UIColor.green
    static let red = UIColor.red
    static let lightGray = UIColor.lightGray
    
    #else
    
    static let black = UIColor(named: "coni_black")!
    static let blue = UIColor(named: "coni_blue")!
    static let gray = UIColor(named: "coni_gray")!
    static let green = UIColor(named: "coni_green")!
    static let red = UIColor(named: "coni_red")!
    static let lightGray = UIColor(named: "coni_lightGray")!
    
    #endif
  }
    
    struct Font {
        static let regular16 = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let regular12 = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let regular14 = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

}
