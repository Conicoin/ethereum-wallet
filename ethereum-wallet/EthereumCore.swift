//
//  EthereumCore.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import Geth


// MARK: - EthereumCoreProtocol

protocol EthereumCoreProtocol {
    func start()
    weak var syncDelegate: EthereumCoreSyncDelegate? { get set }
}


// MARK: - EthereumCoreSyncDelegate

protocol EthereumCoreSyncDelegate: class {
    func didReceiveBlock(_ number: Int64)
    func didFailed(with error: Error)
    func syncProgressDidChange(current: Int64, total: Int64)
    func syncFinished()
}


class Ethereum: EthereumCoreProtocol {
    
    static var core: EthereumCoreProtocol = Ethereum()
    
    weak var syncDelegate: EthereumCoreSyncDelegate?
    
    fileprivate var ethereumContext: GethContext = GethNewContext()
    fileprivate var keystore:        GethKeyStore!
    fileprivate var ethereumNode:    GethNode!
    fileprivate var lastSeenBlock:   Int64?
    fileprivate var balance:         Balance!
   
    fileprivate var isSyncMode = false
    
    func start() {
        
        Global { [unowned self] in
            do {
                try self.startNode()
                try self.subscribeNewHead()
                try self.startProgressTicks()
                
            } catch {
                Main {
                    self.syncDelegate?.didFailed(with: error)
                }
            }
        }
        
    }
    
    fileprivate func startNode() throws {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        keystore = GethNewKeyStore(documentDirectory + "/keystore", GethLightScryptN, GethLightScryptP)
        
        var error: NSError?
        let bootNodes = GethNewEnodesEmpty()
        bootNodes?.append(GethNewEnode(Constants.Ethereum.enodeRawUrl, &error))
        
        let genesisPath = Bundle.main.path(forResource: "rinkeby", ofType: "json")
        let genesis = try! String(contentsOfFile: genesisPath!, encoding: String.Encoding.utf8)
        
        let config = GethNewNodeConfig()
        config?.setBootstrapNodes(bootNodes)
        config?.setEthereumGenesis(genesis)
        config?.setEthereumNetworkID(4)
        config?.setEthereumNetStats("flypaper:Respect my authoritah!@stats.rinkeby.io")
        
        let datadir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        ethereumNode = GethNewNode(datadir, config, &error)
        
        try ethereumNode.start()
        
        if let error = error {
            throw EthereumError.nodeStartFailed(error: error)
        }
    }
    
    fileprivate func subscribeNewHead() throws {
        
        let handler = NewHeadHandler(errorHandler: nil) { header in
            Main {
                self.syncDelegate?.didReceiveBlock(header.getNumber())
            }
        }
        
        try ethereumNode.getEthereumClient().subscribeNewHead(ethereumContext, handler: handler, buffer: 16)
    }
    
    fileprivate func startProgressTicks() throws {
        Main {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if let syncProgress = try? self.ethereumNode.getEthereumClient().syncProgress(self.ethereumContext) {
                    self.syncDelegate?.syncProgressDidChange(current: syncProgress.getCurrentBlock(), total: syncProgress.getHighestBlock())
                    self.isSyncMode = true
                } else if self.isSyncMode {
                    self.syncDelegate?.syncFinished()
                    self.isSyncMode = false
                    timer.invalidate()
                }
            }
        }
    }
    
}
