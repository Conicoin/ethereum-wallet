// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit

extension String {
  
  func isValidAddress() -> Bool {
    return count == 42 && self[0..<2] == "0x"
      && (try? Data(hexString: self)) != nil
  }
  
  func retriveAddress() -> String {
    let parts = components(separatedBy: ":")
    return parts.last ?? self
  }
  
  func deleting0x() -> String {
    var string = self
    if starts(with: "0x") {
      string.removeFirst(2)
    }
    return string
  }

}
