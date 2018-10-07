// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

enum FloatingButtonStyle: Int {
  case blue
  case white
}

@IBDesignable
class DefaultButton: ResponsiveButton {
  
  @IBInspectable var butonStyleRaw: Int = 0 {
    didSet {
      updateAppearance()
    }
  }
  
  var buttonStyle: FloatingButtonStyle  {
    return FloatingButtonStyle(rawValue: butonStyleRaw) ?? .blue
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    setBackgroundImage(nil, for: .normal)
    setTitleColor(.white, for: .normal)
    clipsToBounds = false
    updateAppearance()
  }
  
  private func updateAppearance() {
    if !isEnabled {
      layer.shadowOpacity = 0.08
      layer.shadowRadius = 4
      layer.shadowOffset = CGSize(width: 0, height: 8)
    } else if isHighlighted {
      layer.shadowOpacity = 0.4
      layer.shadowRadius = 8
      layer.shadowOffset = CGSize(width: 0, height: 4)
    } else {
      layer.shadowOpacity = 0.2
      layer.shadowRadius = 16
      layer.shadowOffset = CGSize(width: 0, height: 8)
    }
    let background = getBackgroundColor()
    backgroundColor = isEnabled ? background : background.withAlphaComponent(0.5)
    layer.shadowColor = getShadowColor()
  }
  
  private func getBackgroundColor() -> UIColor {
    switch buttonStyle {
    case .blue:
      return Theme.Color.blue
    case .white:
      return UIColor.white
    }
  }
  
  fileprivate func getShadowColor() -> CGColor {
    switch buttonStyle {
    case .blue:
      return Theme.Color.blue.cgColor
    case .white:
      return Theme.Color.black.cgColor
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = min(bounds.width, bounds.height) * 0.5
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: UIView.noIntrinsicMetric, height: 48)
  }
  
  override var isHighlighted: Bool {
    didSet {
      if isHighlighted != oldValue {
        UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState,
                       animations: updateAppearance, completion: nil)
      }
    }
  }
  
  override var isEnabled: Bool {
    didSet {
      if isEnabled != oldValue {
        UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState,
                       animations: updateAppearance, completion: nil)
      }
    }
  }
  
  override func action(for layer: CALayer, forKey event: String) -> CAAction? {
    if ["shadowOpacity", "shadowRadius", "shadowOffset", "backgroundColor"].contains(event) {
      return CABasicAnimation()
    } else {
      return super.action(for: layer, forKey: event)
    }
  }
}
