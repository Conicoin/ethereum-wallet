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
    
    var syncHandler: SyncHandler? { get set }
    
    func startSync(balanceHandler: BalanceHandler, syncHandler: SyncHandler?) throws
    func createAccount(passphrase: String) throws -> GethAccount
    func jsonKey(for account: GethAccount, passphrase: String) throws -> Data
    func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount
}


class Ethereum: EthereumCoreProtocol {
    
    static var core: EthereumCoreProtocol = Ethereum()
    
    internal var syncHandler: SyncHandler?
    
    fileprivate lazy var keystore: GethKeyStore! = {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return GethNewKeyStore(documentDirectory + "/keystore", GethLightScryptN, GethLightScryptP)
    }()
    
    fileprivate var ethereumContext: GethContext = GethNewContext()
    fileprivate var balanceHandler:  BalanceHandler!
    fileprivate var ethereumNode:    GethNode!
   
    fileprivate var isSyncMode = false
    
    
    // MARK: - Synchronization public
    
    func startSync(balanceHandler: BalanceHandler, syncHandler: SyncHandler?) throws {
            self.balanceHandler = balanceHandler
            self.syncHandler = syncHandler
        try self.startNode()
        try self.subscribeNewHead()
        try self.startProgressTicks()
    }
    
    
    // MARK: - Acount managment public
    
    func createAccount(passphrase: String) throws -> GethAccount {
        guard keystore.getAccounts().size() == 0 else {
            throw EthereumError.accountExist
        }
        
        return try keystore.newAccount(passphrase)
    }
    
    func jsonKey(for account: GethAccount, passphrase: String) throws -> Data {
        return try keystore.exportKey(account, passphrase: passphrase, newPassphrase: passphrase)
    }
    
    func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount  {
        return try keystore.importKey(jsonKey, passphrase: passphrase, newPassphrase: passphrase)
    }
    
}


// MARK: - Synchronization privates

extension Ethereum {
    
    fileprivate func startNode() throws {
        
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
        
        let newBlockHandler = NewHeadHandler(errorHandler: nil) { header in
            do {
                let address = try self.keystore.getAccounts().get(0).getAddress()
                let balance = try self.ethereumNode.getEthereumClient().getBalanceAt(self.ethereumContext, account: address, number: header.getNumber())
                
                self.balanceHandler.didUpdateBalance(balance.getInt64())
            } catch {}
        }
        
        try ethereumNode.getEthereumClient().subscribeNewHead(ethereumContext, handler: newBlockHandler, buffer: 16)
    }
    
    fileprivate func startProgressTicks() throws {
        Main {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if let syncProgress = try? self.ethereumNode.getEthereumClient().syncProgress(self.ethereumContext) {
                    self.syncHandler?.didChangeProgress(syncProgress.getCurrentBlock(), syncProgress.getHighestBlock())
                    self.isSyncMode = true
                } else if self.isSyncMode {
                    self.syncHandler?.didFinished()
                    self.isSyncMode = false
                    timer.invalidate()
                }
            }
        }
    }
    
}
