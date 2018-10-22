// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import ObjectMapper

struct TokenMeta {
  var value: TokenValue
  var address: String
}

// MARK: - RealmMappable

extension TokenMeta: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmTokenMeta) -> TokenMeta {
    let value = TokenValue(wei: Decimal(object.amount), name: object.name, iso: object.symbol, decimals: object.decimals)
    let address = object.address
    return TokenMeta(value: value, address: address)
  }
  
  func mapToRealmObject() -> RealmTokenMeta {
    let realmObject = RealmTokenMeta()
    realmObject.amount = value.raw.string
    realmObject.name = value.name
    realmObject.symbol = value.symbol
    realmObject.decimals = value.decimals
    realmObject.address = address
    return realmObject
  }
  
}


// MARK: - ImmutableMappable

extension TokenMeta: ImmutableMappable {
  
  init(map: Map) throws {
    let amount = try map.value("value") as String
    let name = try map.value("tokenName") as String
    let iso = try map.value("tokenSymbol") as String
    let decimals = Int(try map.value("tokenDecimal") as String) ?? 0
    value = TokenValue(wei: Decimal(amount), name: name, iso: iso, decimals: decimals)
    address = try map.value("contractAddress")
  }
  
}
