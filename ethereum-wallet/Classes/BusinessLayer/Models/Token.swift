// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import RealmSwift
import ObjectMapper

struct Token {
  
  var balance: Currency!
  var lastUpdateTime = Date()
  var address: String!
  var decimals: Int!
  
}

// MARK: - RealmMappable

extension Token: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmToken) -> Token {
    var token = Token()
    let tokenValue = TokenValue(wei: Decimal(object.balance), name: object.name, iso: object.iso, decimals: object.decimals)
    token.balance = tokenValue
    token.lastUpdateTime = object.lastUpdateTime
    token.address = object.address
    token.decimals = object.decimals
    return token
  }
  
  func mapToRealmObject() -> RealmToken {
    let realmObject = RealmToken()
    realmObject.balance = balance.raw.string
    realmObject.name = balance.name
    realmObject.iso = balance.symbol
    realmObject.lastUpdateTime = lastUpdateTime
    realmObject.address = address
    realmObject.decimals = decimals
    return realmObject
  }
  
}

// MARK: - ImmutableMappable

extension Token: ImmutableMappable {
  
  init(map: Map) throws {
    address = try map.value("contract.contract")
    decimals = try map.value("contract.decimals")
    
    let balanceString: String = try map.value("balance")
    let balanceDecimal = Decimal(balanceString)
    let name: String = try map.value("contract.name")
    let iso: String = try map.value("contract.symbol")
    balance = TokenValue(wei: balanceDecimal, name: name, iso: iso, decimals: decimals)
  }
  
}

// MARK: - Equatable

extension Token: Equatable {
  
  static func == (lhs: Token, rhs: Token) -> Bool {
    return lhs.address == rhs.address
    && lhs.balance.amountString == rhs.balance.amountString
  }
  
}
