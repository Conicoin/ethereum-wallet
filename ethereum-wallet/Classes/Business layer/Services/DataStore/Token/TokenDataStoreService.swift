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

class TokenDataStoreService: RealmStorable<Token>, TokenDataStoreServiceProtocol {
  
  override func save(_ models: [Token]) {
    let realm = try! Realm()
    try! realm.write {
      realm.delete(realm.objects(RealmToken.self))
      let models = models.map { token -> RealmToken in
        let realmObject = token.mapToRealmObject()
        if let oldToken = realm.objects(RealmToken.self).filter("name = '\(token.balance.name)'").first {
          if token.rates.isEmpty {
            realmObject.rates = oldToken.rates
          }
        }
        return realmObject
      }
      realm.add(models, update: true)
    }
  }
  
}
