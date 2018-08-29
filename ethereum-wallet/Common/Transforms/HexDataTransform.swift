// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import ObjectMapper

class HexDataTransform: TransformType {
  public typealias Object = Data
  public typealias JSON = String
  
  public init() {}
  
  open func transformFromJSON(_ value: Any?) -> Data? {
    guard let string = value as? String, let data = string.toHexData() else {
      return nil
    }
    return data
  }
  
  open func transformToJSON(_ value: Data?) -> String? {
    guard let data = value else{
      return nil
    }
    return data.hex()
  }
}
