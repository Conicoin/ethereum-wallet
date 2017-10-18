//
//  TransactionsService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

protocol TransactionsServiceDelegate: class {
    func didFailed(with error: Error)
}

class TransactionsService {
    
    weak var delegate: TransactionsServiceDelegate?
    
    init(delegate: TransactionsServiceDelegate) {
        self.delegate = delegate
    }
    
    func getTransactionsList() {
        let address = Wallet.returnWallet().address
        Networking.shared.loadArray(request: API.Transaction.list(address: address), keyPath: "result") { (result: Result<[Transaction]> )in
            switch result {
            case .success(let value):
                Transaction.save(value)
            case .failure(let error):
                self.delegate?.didFailed(with: error)
            }
        }
    }

}
