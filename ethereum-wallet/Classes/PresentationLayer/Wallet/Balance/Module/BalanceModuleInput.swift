// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol BalanceModuleInput: class {
  var output: BalanceModuleOutput? { get set }
  var viewController: UIViewController { get }
}
