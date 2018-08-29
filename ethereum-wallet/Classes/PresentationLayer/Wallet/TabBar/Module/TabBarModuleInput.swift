// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol TabBarModuleInput: class  {
  var output: TabBarModuleOutput? { get set }
  func present()
}
