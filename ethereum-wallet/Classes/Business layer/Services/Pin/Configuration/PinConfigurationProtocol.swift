// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

protocol PinConfigurationProtocol {
    
    var repository: PinRepositoryProtocol { get }
    var pinLength: Int { get }
    var isTouchIDAllowed: Bool { get }
    var shouldRequestTouchIDImmediately: Bool { get }
    var maximumInccorectPinAttempts: Int { get }
}
