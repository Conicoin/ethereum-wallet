// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

struct Function: Equatable, CustomStringConvertible {
  var name: String
  var parameters: [ABIType]
  
  init(name: String, parameters: [ABIType]) {
    self.name = name
    self.parameters = parameters
  }
  
  /// Casts the arguments into the appropriate types for this function.
  ///
  /// - Throws:
  ///   - `ABIError.invalidArgumentType` if a value doesn't match the expected type.
  ///   - `ABIError.invalidNumberOfArguments` if the number of values doesn't match the number of parameters.
  func castArguments(_ values: [Any]) throws -> [ABIValue] {
    if values.count != parameters.count {
      throw ABIError.invalidNumberOfArguments
    }
    return try zip(parameters, values).map({ try ABIValue($1, type: $0) })
  }
  
  /// Function signature
  var description: String {
    let descriptions = parameters.map({ $0.description }).joined(separator: ",")
    return "\(name)(\(descriptions))"
  }
}

