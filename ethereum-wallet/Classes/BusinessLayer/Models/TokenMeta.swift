// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import ObjectMapper

struct TokenMeta {
  var address: String!
  var name: String!
  var iso: String!
  var decimals: Int!
}

// MARK: - RealmMappable

extension TokenMeta: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmTokenMeta) -> TokenMeta {
    var tokenMeta = TokenMeta()
    tokenMeta.name = object.name
    tokenMeta.iso = object.symbol
    tokenMeta.address = object.address
    tokenMeta.decimals = object.decimals
    return tokenMeta
  }
  
  func mapToRealmObject() -> RealmTokenMeta {
    let realmObject = RealmTokenMeta()
    realmObject.name = name
    realmObject.symbol = iso
    realmObject.address = address
    realmObject.decimals = decimals
    return realmObject
  }
  
}

// MARK: - ImmutableMappable

extension TokenMeta: ImmutableMappable {
  
  init(map: Map) throws {
    name = try map.value("name")
    iso = try map.value("symbol")
    address = try map.value("address")
    decimals = try map.value("decimals")
  }
  
}
