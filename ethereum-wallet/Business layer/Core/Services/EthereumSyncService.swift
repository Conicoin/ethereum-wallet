//
//  EthereumSyncService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


// MARK: - EthereumSyncDelegate

protocol EthereumSyncDelegate: class {
    func didReceiveBlock(_ number: Int64)
    func didFailed(with error: Error)
    func syncProgressDidChange(current: Int64, total: Int64)
    func syncFinished()
}

struct EthereumSyncService {
    
    weak var delegate: EthereumSyncDelegate?
    
    init(delegate: EthereumSyncDelegate? = nil) {
        self.delegate = delegate
    }
    
    func start() {
        
        let handler = SyncHandler(didReceiveBlock: { number in
            self.delegate?.didReceiveBlock(number)
        }, didChangeProgress: { current, total in
            self.delegate?.syncProgressDidChange(current: current, total: total)
        }) { 
            self.delegate?.syncFinished()
        }
        
        
        Global {
            do  {
                try Ethereum.core.startSync(handler)
                
            } catch {
                Main {
                    self.delegate?.didFailed(with: error)
                }
            }
        }
        
        
    }

}
