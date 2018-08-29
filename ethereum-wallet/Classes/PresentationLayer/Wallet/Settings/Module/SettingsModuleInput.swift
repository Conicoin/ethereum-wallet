// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit


protocol SettingsModuleInput: class {
  var output: SettingsModuleOutput? { get set }
  var viewController: UIViewController { get }
}
