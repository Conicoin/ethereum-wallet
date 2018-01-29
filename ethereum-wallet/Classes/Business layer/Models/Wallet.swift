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

struct Wallet {
  
  var address: String!
  var localCurrency: String!
  var gasLimit: Decimal!
  
}

// MARK: - RealmMappable

extension Wallet: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmWallet) -> Wallet {
    var wallet = Wallet()
    wallet.address = object.address
    wallet.localCurrency = object.localCurrency
    wallet.gasLimit = Decimal(string: object.gasLimit)
    return wallet
  }
  
  func mapToRealmObject() -> RealmWallet {
    let realmObject = RealmWallet()
    realmObject.address = address
    realmObject.localCurrency = localCurrency
    realmObject.gasLimit = "\(gasLimit)"
    return realmObject
  }
  
}
