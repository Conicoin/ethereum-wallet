// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
