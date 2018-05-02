//
//  TxMetaResolver.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

enum TxType: Equatable {
  case normal
  case erc20(to: String, value: String)
  case unknown
}

protocol TxMetaResolver {
  var nextResolver: TxMetaResolver? { get set } 
  func resolve(_ input: Data) -> TxType
  
  @discardableResult
  func chain(_ next: TxMetaResolver) -> TxMetaResolver
}

extension TxMetaResolver {
  func nextResolver(for input: Data) -> TxType {
    guard let next = nextResolver else {
      return .unknown
    }
    return next.resolve(input)
  }
}
