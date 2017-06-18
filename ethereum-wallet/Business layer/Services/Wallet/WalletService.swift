//
//  WalletService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 24/05/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

protocol WalletServiceDelegate: class {
    
    func addressCreationFailed(error: Error)
    
}

class WalletService {
    
    internal var delegate: WalletServiceDelegate
    
    fileprivate var wallet: WalletProtocol = Wallet()
    
    init(delegate: WalletServiceDelegate) {
        self.delegate = delegate
    }
    
    func createAddress() {
        wallet.createAccount()
    }

}

