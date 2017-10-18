//
//  RootTabBarController.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    lazy var syncService: EthereumSyncService = EthereumSyncService(delegate: self)
    
    var blanceViewController: BalanceViewController {
        return viewControllers!.first as! BalanceViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("START!@#!@#!@#")
        syncService.start()
    }

}


// MARK: - EthereumSyncDelegate

extension RootTabBarController: EthereumSyncDelegate {

    func syncDidChangeBalance() {
        blanceViewController.updateBalance()
    }
    
    func syncDidFailedWithError(_ error: Error) {
        error.showAllertIfNeeded(from: self)
    }
    
    func syncDidChangeProgress(current: Int64, total: Int64) {
        
    }
    
    func syncDidFinished() {
        NSLog("syncDidFinished")
    }
    
}
