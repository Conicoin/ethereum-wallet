//
//  PushNetworkingProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 01/06/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol PushNetworkServiceProtocol {
  func register(token: String, address: String, queue: DispatchQueue, result: @escaping (Result<Bool>) -> Void)
  func unregister(queue: DispatchQueue, result: @escaping (Result<Bool>) -> Void)
}
