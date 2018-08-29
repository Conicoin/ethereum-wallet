// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

protocol PushNetworkServiceProtocol {
  func register(token: String, address: String, queue: DispatchQueue, result: @escaping (Result<Bool>) -> Void)
  func unregister(queue: DispatchQueue, result: @escaping (Result<Bool>) -> Void)
}
