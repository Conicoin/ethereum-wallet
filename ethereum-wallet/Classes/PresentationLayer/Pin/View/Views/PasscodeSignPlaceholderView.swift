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

class PasscodeSignPlaceholderView: UIView {
  
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
