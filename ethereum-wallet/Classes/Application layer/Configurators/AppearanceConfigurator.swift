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

class AppearanceConfigurator: ConfiguratorProtocol {
  
  func configure() {
    let back = UIImage(named: "BackIcon")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: -2, right: 0))
    UINavigationBar.appearance().backIndicatorImage = back
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = back
    UINavigationBar.appearance().isTranslucent = true
    UINavigationBar.appearance().barTintColor = .white
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.Color.black]
    UINavigationBar.appearance().shadowImage = UIImage()
    UIBarButtonItem.appearance().tintColor = Theme.Color.black
    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -100, vertical:0), for: .default)
  }
  
}
