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
    static let black = UIColor(red: 25/255, green: 28/255, blue: 31/255, alpha: 1)
    static let blue = UIColor(red: 19/255, green: 121/255, blue: 222/255, alpha: 1)
    static let gray = UIColor(red: 139/255, green: 149/255, blue: 158/255, alpha: 1)
    static let green = UIColor(red: 89/255, green: 172/255, blue: 15/255, alpha: 1)
    static let red = UIColor(red: 220/255, green: 62/255, blue: 32/255, alpha: 1)
    static let ethereum = UIColor(red: 19/255, green: 121/255, blue: 222/255, alpha: 1)
    static let token = UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1)
  }
    
    struct Font {
        static let regular16 = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let regular12 = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let regular14 = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

}
