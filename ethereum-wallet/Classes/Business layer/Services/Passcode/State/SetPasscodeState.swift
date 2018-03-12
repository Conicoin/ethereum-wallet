//
//  SetPasscodeState.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

struct SetPasscodeState: PasscodeStateProtocol {
    
    let title: String
    let isCancellableAction = true
    var isTouchIDAllowed = false
    
    init(title: String) {
        self.title = title
    }
    
    init() {
        title = Localized.passcodeSetTitle()
    }
    
    func acceptPasscode(_ passcode: [String], fromLock lock: PasscodeServiceProtocol) {
        let nextState = ConfirmPasscodeState(passcode: passcode)
        lock.changeStateTo(nextState)
    }
}
