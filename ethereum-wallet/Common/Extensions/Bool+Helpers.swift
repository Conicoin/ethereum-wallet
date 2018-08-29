// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

extension Bool {
  init<T: BinaryInteger>(_ num: T) {
    self.init(num != 0)
  }
  
  init(_ string: String) {
    self.init(string != "0")
  }
  
  var intValue: Int {
    return self ? 1 : 0
  }
}
