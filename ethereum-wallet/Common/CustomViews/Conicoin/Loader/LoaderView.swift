//
//  LoaderView.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 23/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class LoaderView: UIView {
  
  enum LoaderType {
    case loading
    
    var radius: CGFloat {
      return 28
    }
    
    var duration: Double {
      return 1
    }
  }
  
  let type: LoaderType
  let circle = CAShapeLayer()
  
  init(frame: CGRect, type: LoaderType) {
    self.type = type
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.type = .loading
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    backgroundColor = .white
    
    let center = CGPoint(x: bounds.midX, y: bounds.midY)
    let radius = min(bounds.width, bounds.height) / 2 - circle.lineWidth/2
    
    let startAngle = -CGFloat.pi/2
    let endAngle = startAngle + 2*CGFloat.pi
    let path = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    
    circle.fillColor = UIColor.clear.cgColor
    circle.strokeColor = Theme.Color.blue.cgColor
    circle.position = center
    circle.path = path.cgPath
    circle.lineWidth = 2.4
    layer.addSublayer(circle)
    
    circle.add(strokeEndAnimation(type.duration), forKey: "strokeEnd")
    circle.add(strokeStartAnimation(type.duration), forKey: "strokeStart")
  }
  
  
  private func strokeEndAnimation(_ duration: Double) -> CAAnimation {
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.fromValue = 0
    animation.toValue = 1
    animation.duration = duration
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
  
    let group = CAAnimationGroup()
    group.duration = 1.5
    group.repeatCount = MAXFLOAT
    group.animations = [animation]
    
    return group
  }
  
  private func strokeStartAnimation(_ duration: Double) -> CAAnimation {
    let animation = CABasicAnimation(keyPath: "strokeStart")
    animation.beginTime = 0.5
    animation.fromValue = 0
    animation.toValue = 1
    animation.duration = duration
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
    let group = CAAnimationGroup()
    group.duration = duration + 0.5
    group.repeatCount = MAXFLOAT
    group.animations = [animation]
    
    return group
  }
  
}
