//
//  TransactionsViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import RealmSwift

class TransactionsViewController: UIViewController {
    
    lazy var service: TransactionsService = TransactionsService(delegate: self)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO
//        manager.startManaging(withDelegate: self)
//        manager.register(TransactionCell.self)
        
        let address = Wallet.returnWallet().address
        let stored = Transaction.getTransactions(for: address)
//        manager.storage = RealmStorage()
//        (manager.storage as! RealmStorage).addSection(with: stored)
    }
    
    
    @IBAction func test(_ sender: UIBarButtonItem) {
        let realm = try! Realm()
        let objects = realm.objects(Transaction.self)
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        service.getTransactionsList()
        NSLog("ViewWillAppear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - TransactionsServiceDelegate

extension TransactionsViewController: TransactionsServiceDelegate {
    
    func didFailed(with error: Error) {
        error.showAllertIfNeeded(from: self)
    }
    
}
