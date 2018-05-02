// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import ObjectMapper

struct TokenMeta {
  var address: String!
  var name: String!
  var iso: String!
  var decimals: Int64!
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
