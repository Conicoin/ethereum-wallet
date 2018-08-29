// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit


protocol ScanModuleInput: class {
  var output: ScanModuleOutput? { get set }
  func present(from: UIViewController, output: ScanModuleOutput)
}
