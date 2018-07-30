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


import RealmSwift
import ObjectMapper

struct Token {
  
  var balance: Currency!
  var rates = [Rate]()
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
    token.rates = object.rates.map { Rate.mapFromRealmObject($0) }
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
    realmObject.rates.append(objectsIn: rates.map { $0.mapToRealmObject() })
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
