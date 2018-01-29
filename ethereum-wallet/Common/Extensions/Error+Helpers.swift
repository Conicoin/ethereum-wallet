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

extension Error {
    
    func smartDescription() -> String? {
        if let error = self as? CustomError {
            return error.description?.message
        }
        return localizedDescription
    }
    
    func showAllertIfNeeded(from viewController: UIViewController) {
        if
          let error = self as? CustomError,
          let description = error.description, description.showing {
            let alert = UIAlertController(title: description.title, message: description.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: self.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
