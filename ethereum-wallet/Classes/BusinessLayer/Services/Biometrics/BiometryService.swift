// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit
import Foundation
import LocalAuthentication

enum BiometryType {
  case touchId
  case faceId
  case none
  
  var isBiometryAvailable: Bool {
    return self != .none
  }
  
  var label: String {
    switch self {
    case .faceId:
      return Localized.commonFaceId()
    default:
      return Localized.commonTouchId()
    }
  }
}

protocol BiometryServiceProtocol {
  var biometry: BiometryType { get }
  var isBiometryAvailable: Bool { get }
  
  @discardableResult
  func canEvaluatePolicy() throws -> Bool
  func authenticate(fallback: String, reason: String, result: @escaping (Result<Bool>) -> Void)
}

class BiometryService: BiometryServiceProtocol {
  
  private let context = LAContext()
  private let policity: LAPolicy = .deviceOwnerAuthentication
  
  var biometry: BiometryType {
    switch biometryType() {
    case .faceID: return .faceId
    case .touchID: return .touchId
    case .none: return .none
    }
  }
  
  var isBiometryAvailable: Bool {
    return biometry.isBiometryAvailable
  }
  
  @discardableResult
  func canEvaluatePolicy() throws -> Bool {
    var error: NSError?
    let isSuccess = context.canEvaluatePolicy(policity, error: &error)
    guard error == nil else {
      throw TouchIdError.error(error: error, biometry: biometry)
    }
    return isSuccess
  }
  
  func authenticate(fallback: String, reason: String, result: @escaping (Result<Bool>) -> Void) {
    context.localizedFallbackTitle = fallback
    
    do {
      guard try canEvaluatePolicy() else {
        result(.failure(TouchIdError.error(error: nil, biometry: biometry)))
        return
      }
    } catch {
      result(.failure(error))
      return
    }
    
    context.evaluatePolicy(policity, localizedReason: reason) {  success, error in
      result(.success(success))
    }
  }
  
  // MARK: Privates
  
  private func biometryType() -> LABiometryType {
    _ = try? canEvaluatePolicy()
    return context.biometryType
  }
  
}
