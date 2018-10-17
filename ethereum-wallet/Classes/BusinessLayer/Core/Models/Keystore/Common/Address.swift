// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

struct Address: Hashable {
  static let size = 20
  
  /// Validates that the raw data is a valid address.
  static func isValid(data: Data) -> Bool {
    return data.count == Address.size
  }
  
  /// Validates that the string is a valid address.
  static func isValid(string: String) throws -> Bool {
    let data = try Data(hexString: string)
    return Address.isValid(data: data)
  }
  
  /// Raw address bytes, length 20.
  let data: Data
  
  /// EIP55 representation of the address.
  let string: String
  
  /// Creates an address with `Data`.
  ///
  /// - Precondition: data contains exactly 20 bytes
  init(data: Data) throws {
    if !Address.isValid(data: data) {
      throw AddressError.invalidAddress
    }
    self.data = data
    string = Address.computeEIP55String(for: data)
  }
  
  /// Creates an address with an hexadecimal string representation.
  init?(string: String) {
    let rawString = string.lowercased().deleting0x()
    guard let data = try? Data(hexString: rawString), data.count == Address.size else {
      return nil
    }
    self.data = data
    self.string = Address.computeEIP55String(for: data)
  }
  
  var description: String {
    return string
  }
  
  var hashValue: Int {
    return data.hashValue
  }
  
  static func == (lhs: Address, rhs: Address) -> Bool {
    return lhs.data == rhs.data
  }
}

extension Address {
  /// Converts the address to an EIP55 checksumed representation.
  fileprivate static func computeEIP55String(for data: Data) -> String {
    let addressString = data.hex()
    let hashInput = addressString.data(using: .ascii)!
    let hash = CryptoHash.sha256(hashInput).hex()
    
    var string = "0x"
    for (a, h) in zip(addressString, hash) {
      switch (a, h) {
      case ("0", _), ("1", _), ("2", _), ("3", _), ("4", _), ("5", _), ("6", _), ("7", _), ("8", _), ("9", _):
        string.append(a)
      case (_, "8"), (_, "9"), (_, "a"), (_, "b"), (_, "c"), (_, "d"), (_, "e"), (_, "f"):
        string.append(contentsOf: String(a).uppercased())
      default:
        string.append(contentsOf: String(a).lowercased())
      }
    }
    
    return string
  }
}

enum AddressError: Error {
  case invalidAddress
}

