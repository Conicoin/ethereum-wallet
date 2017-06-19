//
//  BalanceViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBalance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - RootTabBarController commands

extension BalanceViewController {
    
    func updateBalance() {
        balanceLabel?.text = "\(Wallet.returnWallet().balance)"
    }
    
}
