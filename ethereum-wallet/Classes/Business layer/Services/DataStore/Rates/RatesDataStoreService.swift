// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit

class RatesDataStoreService: RealmStorable<Rate>, RatesDataStoreServiceProtocol {
  
  func getRates(currency: String) -> [Rate] {
    return find().filter { $0.from == currency}
  }
  
}
