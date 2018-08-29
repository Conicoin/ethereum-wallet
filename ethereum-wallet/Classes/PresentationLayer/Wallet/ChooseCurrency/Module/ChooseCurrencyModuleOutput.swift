// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol ChooseCurrencyModuleOutput: class {
  func didSelectCurrency(_ currency: FiatCurrency)
}
