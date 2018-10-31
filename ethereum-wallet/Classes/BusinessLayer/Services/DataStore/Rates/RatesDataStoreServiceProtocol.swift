// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit

protocol RatesDataStoreServiceProtocol {
  func find() -> [Rate]
  func getRates(currency: String) -> [Rate]
  func save(_ rates: [Rate])
  func observe(updateHandler: @escaping ([Rate]) -> Void)
}
