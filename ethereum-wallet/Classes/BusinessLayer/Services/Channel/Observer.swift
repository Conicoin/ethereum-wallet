// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

struct Identifier: Hashable {
  private let id: String
  
  init(_ id: String) {
    self.id = id
  }
  
  init() {
    self.id = UUID().uuidString
  }
  
  // MARK: Hashable
  var hashValue: Int {
    return id.hashValue
  }
  
  static func == (_ lhs: Identifier, _ rhs: Identifier) -> Bool {
    return lhs.id == rhs.id
  }
}

extension Identifier: ExpressibleByStringLiteral {
  typealias StringLiteralType = String
  init(stringLiteral value: String) {
    self.id = value
  }
}

class Observer<SignalData> {
  typealias Callback = (SignalData) -> Void
  
  let id: Identifier
  private let callback: Callback
  
  init(id: Identifier, callback: @escaping Callback) {
    self.id = id
    self.callback = callback
  }
  
  func send(_ value: SignalData) {
    self.callback(value)
  }
}

extension Observer: Hashable {
  var hashValue: Int {
    return self.id.hashValue
  }
  
  static func == (_ lhs: Observer, _ rhs: Observer) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }
}

extension Observer {
  convenience init(id: String, callback: @escaping Callback) {
    self.init(id: Identifier(id), callback: callback)
  }
}
