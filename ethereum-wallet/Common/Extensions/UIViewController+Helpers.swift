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

extension UIViewController {
  
  func wrapToNavigationController() -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: self)
    return navigationController
  }
  
  func addBackgroundImage(_ backgoundImage: UIImage) {
    let imageView = UIImageView(image: backgoundImage)
    imageView.frame = view.bounds
    view.insertSubview(imageView, at: 0)
  }
  
  func showAlert(title: String?, message: String?, cancelable: Bool = false,  handler: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    if cancelable {
      alert.addAction(UIAlertAction(title: Localized.commonCancel(), style: .cancel, handler: nil))
    }
    alert.addAction(UIAlertAction(title: Localized.commonOk(), style: .default, handler: handler))
    present(alert, animated: true, completion: nil)
  }
  
  func pop() {
    navigationController?.popViewController(animated: true)
  }
  
  func popToRoot() {
    navigationController?.popToRootViewController(animated: true)
  }

}
