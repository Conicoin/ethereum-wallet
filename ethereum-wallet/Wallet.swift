//
//  Wallet.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 31/05/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import Geth

protocol WalletProtocol {
    
    var balance: Balance! { get set }
    
    func createAccount()
}

class Wallet: WalletProtocol {
    
    var balance: Balance!

    func createAccount() {
        
    }
 
}
