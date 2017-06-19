//
//  RootTabBarController.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    lazy var syncService: EthereumSyncService = EthereumSyncService(delegate: self)
    
    var blanceViewController: BalanceViewController {
        return viewControllers!.first as! BalanceViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncService.start()
    }

}


// MARK: - EthereumSyncDelegate

extension RootTabBarController: EthereumSyncDelegate {
    
    func syncDidReceiveBlock(_ number: Int64) {
        
    }
    
    func syncDidChangeBalance() {
        blanceViewController.updateBalance()
    }
    
    func syncDidFailedWithError(_ error: Error) {
        
    }
    
    func syncDidChangeProgress(current: Int64, total: Int64) {
        
    }
    
    func syncDidFinished() {
        
    }
    
}
