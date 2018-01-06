//
//  ImportImportRouter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation
import UIKit

class ImportRouter {

}


// MARK: - ImportRouterInput

extension ImportRouter: ImportRouterInput {
  
  func presentPassword(from viewController: UIViewController) {
    PasswordModule.create().present(from: viewController)
  }
    
}
