//
//  WelcomeWelcomeModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 19/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol WelcomeModuleInput: class {
  var output: WelcomeModuleOutput? { get set }
  var viewController: UIViewController { get }
}
