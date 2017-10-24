//
//  Error+Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 31/05/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

extension Error {
    
    func smartDescription() -> String? {
        if let error = self as? CustomError {
            return error.description?.message
        }
        return localizedDescription
    }
    
    func showAllertIfNeeded(from: UIViewController) {
        if
          let error = self as? CustomError,
          let description = error.description, description.showing {
            let alert = UIAlertController(title: description.title, message: description.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            from.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: self.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            from.present(alert, animated: true, completion: nil)
        }
    }
    
}
