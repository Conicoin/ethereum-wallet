// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation

protocol PinServiceProtocol {
  
  var isTouchIDAllowed: Bool { get }
  
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
