// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol PartnersModuleInput: class {
  var output: PartnersModuleOutput? { get set }
  var viewController: UIViewController { get }
}
