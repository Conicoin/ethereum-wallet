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

protocol PasscodeServiceProtocol {
  
  var isTouchIDAllowed: Bool { get }
  
  var delegate: PasscodeServiceDelegate? { get set }
  var configuration: PasscodeConfigurationProtocol { get }
  var repository: PasscodeRepositoryProtocol { get }
  var lockState: PasscodeStateProtocol { get }
  
  func addSign(_ sign: String)
  func removeSign()
  func changeStateTo(_ state: PasscodeStateProtocol)
  func authenticateWithBiometrics()
}

protocol PasscodeServiceDelegate: class {
  
  func passcodeLockDidSucceed(_ lock: PasscodeServiceProtocol, acceptedPasscode passcode: [String])
  func passcodeLockDidFail(_ lock: PasscodeServiceProtocol)
  func passcodeLockDidChangeState(_ lock: PasscodeServiceProtocol)
  func passcodeLock(_ lock: PasscodeServiceProtocol, addedSignAtIndex index: Int)
  func passcodeLock(_ lock: PasscodeServiceProtocol, removedSignAtIndex index: Int)
}
