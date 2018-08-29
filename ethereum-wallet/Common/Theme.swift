// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
