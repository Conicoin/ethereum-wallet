// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

protocol PushServiceProtocol {
  func registerForRemoteNotifications(_ completion: @escaping (Result<Bool>) -> Void)
  func unregister()
}
