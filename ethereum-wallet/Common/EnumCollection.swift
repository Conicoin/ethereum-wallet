//
//  EnumCollection.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 27/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation

public protocol EnumCollection: Hashable {
  static func cases() -> AnySequence<Self>
  static var allValues: [Self] { get }
}

public extension EnumCollection {
  
  public static func cases() -> AnySequence<Self> {
    return AnySequence { () -> AnyIterator<Self> in
      var raw = 0
      return AnyIterator {
        let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
        guard current.hashValue == raw else {
          return nil
        }
        raw += 1
        return current
      }
    }
  }
  
  public static var allValues: [Self] {
    return Array(self.cases())
  }
}
