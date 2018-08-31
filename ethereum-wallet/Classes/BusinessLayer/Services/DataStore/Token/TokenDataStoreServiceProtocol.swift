// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol TokenDataStoreServiceProtocol {
  func find() -> [Token]
  func save(_ models: [Token])
  func observe(updateHandler: @escaping ([Token]) -> Void)
}
