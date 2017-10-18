//
//  EthereumSyncService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import RealmSwift


// MARK: - EthereumSyncDelegate

protocol EthereumSyncDelegate: class {
    func syncDidChangeBalance()
    func syncDidFailedWithError(_ error: Error)
    func syncDidChangeProgress(current: Int64, total: Int64)
    func syncDidFinished()
}

class EthereumSyncService {
    
    weak var delegate: EthereumSyncDelegate?
    
    fileprivate var notificationToken: NotificationToken?
    
    init(delegate: EthereumSyncDelegate? = nil) {
        self.delegate = delegate
    }
    
    func start() {
        
        let wallet = Wallet.returnWallet()
        notificationToken = wallet.addNotificationBlock { [weak self] change in
            Main { self?.delegate?.syncDidChangeBalance() }
        }
        
        let balanceHandler = BalanceHandler { newBalance in
            wallet.updateBalance(newBalance)
        }
        
        let syncHandler = SyncHandler(didChangeProgress: { current, total in
            self.delegate?.syncDidChangeProgress(current: current, total: total)
        }) { 
            self.delegate?.syncDidFinished()
        }
        
        Global {
            do  {
                try Ethereum.core.startSync(balanceHandler: balanceHandler, syncHandler: syncHandler)
                
            } catch {
                Main {
                    self.delegate?.syncDidFailedWithError(error)
                }
            }
        }
    }

}
