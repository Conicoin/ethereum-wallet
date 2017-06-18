//
//  ApplicationConfigurator.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation

class ApplicationConfigurator: ConfiguratorProtocol {
    
    let syncService = EthereumSyncService()
    
    func configure() {
        
        syncService.start()
        
        if Defaults.isAuthorized {
            AppDelegate.currentWindow.rootViewController = R.storyboard.wallet.instantiateInitialViewController()
        } else {
            AppDelegate.currentWindow.rootViewController = R.storyboard.welcome.instantiateInitialViewController()
        }
        
    }

}
