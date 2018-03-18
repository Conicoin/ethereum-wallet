//
//  DefaultTextFieldUtils.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 10/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

extension UIView {
    var ending: CGPoint { return CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y + frame.height) }
    var viewWidth: CGFloat { return frame.width }
    var viewHeight: CGFloat { return frame.height }
}

extension CGFloat {
    var half: CGFloat { return self / 2 }
    var double: CGFloat { return self * 2 }
}
