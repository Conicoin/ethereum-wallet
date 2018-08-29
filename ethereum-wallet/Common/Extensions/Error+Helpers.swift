// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

extension Error {
  
  func smartDescription() -> String? {
    if let error = self as? CustomError {
      return error.description?.message
    }
    return localizedDescription
  }
  
  func showAllertIfNeeded(from viewController: UIViewController) {
    if let error = self as? CustomError, let description = error.description {
      
      guard description.showing else {
        return
      }
      
      let alert = UIAlertController(title: description.title, message: description.message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: Localized.commonOk(), style: .default, handler: nil))
      viewController.present(alert, animated: true, completion: nil)
    } else {
      let alert = UIAlertController(title: nil, message: self.localizedDescription, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: Localized.commonOk(), style: .default, handler: nil))
      viewController.present(alert, animated: true, completion: nil)
    }
  }
  
}
