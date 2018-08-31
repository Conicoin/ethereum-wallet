// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit

protocol RatesDataStoreServiceProtocol {
  func getRates(currency: String) -> [Rate]
  func observe(updateHandler: @escaping ([Rate]) -> Void)
}
