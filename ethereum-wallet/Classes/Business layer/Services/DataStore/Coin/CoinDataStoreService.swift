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

class CoinDataStoreService: RealmStorable<Coin>, CoinDataStoreServiceProtocol {
    
  func createCoin() {
    var coin = Coin()
    coin.balance = Ether(weiValue: 0)
    save(coin)
  }
  
  func find(withIso iso: String) -> Coin? {
    return findOne("iso = '\(iso)'")
  }
  
  override func save(_ model: Coin) {
    save([model])
  }
  
  override func save(_ models: [Coin]) {
    let realm = try! Realm()
    try! realm.write {
      let models = models.map { coin -> RealmCoin in
        let realmObject = coin.mapToRealmObject()
        if let oldCoin = realm.objects(RealmCoin.self).filter("name = '\(coin.balance.name)'").first {
          if coin.rates.isEmpty {
            realmObject.rates = oldCoin.rates
          }
        }
        return realmObject
      }
      realm.add(models, update: true)
    }
  }
  
}
