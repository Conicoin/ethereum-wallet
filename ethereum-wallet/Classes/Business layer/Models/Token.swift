// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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


import RealmSwift
import ObjectMapper

struct Token {
  
  var balance: Currency!
  var rates = [Rate]()
  var lastUpdateTime = Date()
  var iconUrl: URL?
  var about: String?
  var address: String!
  var totalSupply: String!
  var holdersCount: Int!
  
}

// MARK: - RealmMappable

extension Token: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmToken) -> Token {
    var token = Token()
    let tokenValue = TokenValue(object.balance, name: object.name, iso: object.iso)
    token.balance = tokenValue
    token.rates = object.rates.map { Rate.mapFromRealmObject($0) }
    token.lastUpdateTime = object.lastUpdateTime
    token.iconUrl = URL(string: object.iconURL ?? "")
    token.about = object.about
    token.address = object.address
    token.totalSupply = object.totalSupply
    token.holdersCount = object.holdersCount
    return token
  }
  
  func mapToRealmObject() -> RealmToken {
    let realmObject = RealmToken()
    realmObject.balance = balance.raw.string
    realmObject.name = balance.name
    realmObject.iso = balance.iso
    realmObject.rates.append(objectsIn: rates.map { $0.mapToRealmObject() })
    realmObject.lastUpdateTime = lastUpdateTime
    realmObject.iconURL = iconUrl?.absoluteString
    realmObject.about = about
    realmObject.address = address
    realmObject.totalSupply = totalSupply
    realmObject.holdersCount = holdersCount
    return realmObject
  }
  
}

// MARK: - ImmutableMappable

extension Token: ImmutableMappable {
  
  init(map: Map) throws {
    let count: Any = try map.value("balance")
    let decimalCount = Decimal("\(count)")
    let name: String = try map.value("tokenInfo.name")
    let iso: String = try map.value("tokenInfo.symbol")
    balance = TokenValue(decimalCount, name: name, iso: iso)
    iconUrl = try? map.value("tokenInfo.image")
    about = try? map.value("tokenInfo.description")
    address = try map.value("tokenInfo.address")
    totalSupply = try map.value("tokenInfo.totalSupply")
    holdersCount = try map.value("tokenInfo.holdersCount")
  }
  
}
