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


import Rswift

class ScreenManager {
  
  static func instantiate<ViewController: UIViewController>(_ resource: StoryboardResourceType) -> ViewController {
    let device = UIDevice.screenType
    let storyboard = UIStoryboard(name: resource.name, bundle: nil)
    var viewController: UIViewController!
    do {
      try ObjC.catchException {
        let identifier = resource.name + "ViewController" + device.prefix
        viewController = storyboard.instantiateViewController(withIdentifier: identifier)
      }
    } catch {
      let identifier = resource.name + "ViewController"
      viewController = storyboard.instantiateViewController(withIdentifier: identifier)
    }
    return viewController as! ViewController
  }
  
}
