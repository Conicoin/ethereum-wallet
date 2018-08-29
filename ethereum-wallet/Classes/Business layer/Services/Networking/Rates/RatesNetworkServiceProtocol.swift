// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import Foundation

protocol RatesNetworkServiceProtocol {
  func getRate(currencies: [String], queue: DispatchQueue, completion: @escaping (Result<[Rate]>) -> Void)
}
