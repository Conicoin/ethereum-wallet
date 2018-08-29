// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

class PinSignPlaceholderView: UIView {
  
  enum State {
    case inactive
    case active
    case error
  }
  
  let inactiveColor: UIColor = Theme.Color.blue.withAlphaComponent(0.24)
  let activeColor: UIColor = Theme.Color.blue
  let errorColor: UIColor = Theme.Color.red
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 16, height: 16)
  }
  
  private func setupView() {
    layer.cornerRadius = 6
    backgroundColor = inactiveColor
  }
  
  private func colorsForState(_ state: State) -> (backgroundColor: UIColor, borderColor: UIColor) {
    switch state {
    case .inactive: return (inactiveColor, activeColor)
    case .active: return (activeColor, activeColor)
    case .error: return (errorColor, errorColor)
    }
  }
  
  func animateState(_ state: State) {
    let colors = colorsForState(state)
    backgroundColor = colors.backgroundColor
    layer.borderColor = colors.borderColor.cgColor
  }
}
