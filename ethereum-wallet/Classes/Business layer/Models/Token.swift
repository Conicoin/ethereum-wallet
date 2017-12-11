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

struct Token {
  
  var balance: TokenValue!
  var rates: [Rate]!
  var lastUpdateTime: Date!
  var iconURL: String!
  var about: String!
  var address: String!
  var decimals: Int!
  var totalSupply: String!
  var transfersCount: Int!
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
    token.iconURL = object.iconURL
    token.about = object.about
    token.address = object.address
    token.decimals = object.decimals
    token.totalSupply = object.totalSupply
    token.transfersCount = object.transfersCount
    token.holdersCount = object.holdersCount
    return token
  }
  
  func mapToRealmObject() -> RealmToken {
    let realmObject = RealmToken()
    realmObject.balance = balance.raw.stringValue
    realmObject.name = balance.name
    realmObject.iso = balance.iso
    realmObject.rates.append(objectsIn: rates.map { $0.mapToRealmObject() })
    realmObject.lastUpdateTime = lastUpdateTime
    return realmObject
  }
  
}
