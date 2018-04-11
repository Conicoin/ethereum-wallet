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

struct Coin {
  
  var balance: Currency!
  var rates = [Rate]()
  var lastUpdateTime = Date()
  
}

// MARK: - RealmMappable

extension Coin: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmCoin) -> Coin {
    var coin = Coin()
    coin.balance = Ether(object.balance)
    coin.rates = object.rates.map { Rate.mapFromRealmObject($0) }
    coin.lastUpdateTime = object.lastUpdateTime
    return coin
  }
  
  func mapToRealmObject() -> RealmCoin {
    let realmObject = RealmCoin()
    realmObject.balance = balance.raw.string
    realmObject.name = balance.name
    realmObject.iso = balance.symbol
    realmObject.rates.append(objectsIn: rates.map { $0.mapToRealmObject() })
    realmObject.lastUpdateTime = lastUpdateTime
    return realmObject
  }
  
}
