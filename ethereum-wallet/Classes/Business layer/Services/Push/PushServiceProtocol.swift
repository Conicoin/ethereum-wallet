//
//  PushServiceProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 01/06/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol PushServiceProtocol {
  func registerForRemoteNotifications(_ completion: @escaping (Result<Bool>) -> Void)
  func unregister()
}
