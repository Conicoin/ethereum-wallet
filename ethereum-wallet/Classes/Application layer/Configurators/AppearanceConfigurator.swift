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
    /* Uncomment to use custom icon
    let back = UIImage(named: "BackIcon")
    UIBarButtonItem.appearance().setBackButtonBackgroundImage(back, for: .normal, barMetrics: .defaultPrompt)
    */
    UINavigationBar.appearance().isTranslucent = true
    UINavigationBar.appearance().barTintColor = .clear
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.Color.black]
    UINavigationBar.appearance().shadowImage = UIImage()
    UIBarButtonItem.appearance().tintColor = Theme.Color.black
  }
  
}
