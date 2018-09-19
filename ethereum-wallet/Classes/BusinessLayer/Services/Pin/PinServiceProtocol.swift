// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

protocol PinServiceProtocol {
  
  var isTouchIDAllowed: Bool { get }
  var biometricImage: String { get }
  
  var delegate: PinServiceDelegate? { get set }
  var configuration: PinConfigurationProtocol { get }
  var repository: PinRepositoryProtocol { get }
  var lockState: PinStateProtocol { get }
  
  func addSign(_ sign: String)
  func removeSign()
  func changeStateTo(_ state: PinStateProtocol)
  func authenticateWithBiometrics()
}

protocol PinServiceDelegate: class {
  
  func pinLockDidSucceed(_ lock: PinServiceProtocol, acceptedPin pin: [String])
  func pinLockDidFail(_ lock: PinServiceProtocol)
  func pinLockDidChangeState(_ lock: PinServiceProtocol)
  func pinLock(_ lock: PinServiceProtocol, addedSignAtIndex index: Int)
  func pinLock(_ lock: PinServiceProtocol, removedSignAtIndex index: Int)
}
