//
//  HexDataTransform.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 28/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
    return data.toHexString()
  }
}
