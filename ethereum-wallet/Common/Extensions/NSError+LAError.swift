// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation
import LocalAuthentication

extension NSError {
  
  // TODO: Localize
  
  func touchIdMessage() -> String {
    
    switch code {
      
    case LAError.authenticationFailed.rawValue:
      return "The user failed to provide valid credentials"
      
    case LAError.appCancel.rawValue:
      return "Authentication was cancelled by application"
      
    case LAError.invalidContext.rawValue:
      return "The context is invalid"
      
    case LAError.notInteractive.rawValue:
      return "Not interactive"
      
    case LAError.passcodeNotSet.rawValue:
      return "Passcode is not set on the device"
      
    case LAError.systemCancel.rawValue:
      return "Authentication was cancelled by the system"
      
    case LAError.userCancel.rawValue:
      return "The user did cancel"
      
    case LAError.userFallback.rawValue:
      return "The user chose to use the fallback"
      
    default:
      return unlockMessage()
    }
  }
  
  private func unlockMessage() -> String {
    if #available(iOS 11.0, macOS 10.13, *) {
      switch code {
      case LAError.biometryNotAvailable.rawValue:
        return "Authentication could not start because the device does not support biometric authentication."
        
      case LAError.biometryLockout.rawValue:
        return "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
        
      case LAError.biometryNotEnrolled.rawValue:
        return "Authentication could not start because the user has not enrolled in biometric authentication."
        
      default:
        return "Unknown error"
      }
    } else {
      switch code {
      case LAError.biometryLockout.rawValue:
        return "Too many failed attempts."
        
      case LAError.biometryNotAvailable.rawValue:
        return "TouchID is not available on the device"
        
      case LAError.biometryNotEnrolled.rawValue:
        return "TouchID is not enrolled on the device"
        
      default:
        return "Did not find error code on LAError object"
      }
    }
  }

}
