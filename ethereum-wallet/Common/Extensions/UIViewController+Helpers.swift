// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
