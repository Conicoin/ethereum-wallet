//
//  PasswordViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

class PasswordViewController: UITableViewController {
    
    lazy var accountService: EthereumAccountService = EthereumAccountService(delegate: self)
    
    var password: String!
    
    var restoring: Bool {
        return Keychain.isAccountBackuped
    }
    
    @IBOutlet weak var textField: UITextField!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.enablesReturnKeyAutomatically = true
        
        title = restoring ?
            R.string.localizable.restorePasswordTitle() :
            R.string.localizable.newPasswordTitle()
    }
    
    fileprivate func applyPassword() {
        if restoring {
            accountService.restoreAccount(passphrase: password)
        } else {
            accountService.createAccount(passphrase: password)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didChangePassword(_ sender: UITextField) {
        password = sender.text
    }

    @IBAction func continuePressed(_ sender: UIButton) {
        sender.loadingIndicator(true)
 
    }
}

// MARK: - UITextFieldDelegate

extension PasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        applyPassword()
        return true
    }
    
}


// MARK: - EthereumAccountDelegate

extension PasswordViewController: EthereumAccountDelegate {
    
    func success(account: Account) {
        NSLog("address: %@", account.address)
        Wallet.createWithAddress(account.address)
        Defaults.isAuthorized = true
        
        AppDelegate.currentWindow.rootViewController = R.storyboard.wallet.instantiateInitialViewController()
    }
    
    func didFailed(with error: Error) {
        error.showAllertIfNeeded(from: self)
    }
}
