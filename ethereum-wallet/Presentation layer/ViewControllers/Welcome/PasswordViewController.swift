//
//  PasswordViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import Eureka
import GenericPasswordRow

class PasswordViewController: FormViewController {
    
    lazy var accountService: EthereumAccountService = EthereumAccountService(delegate: self)
    
    @IBOutlet weak var continueButton: UIButton!
    
    var password: String!
    
    var restoring: Bool {
        return Keychain.isAccountBackuped
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = restoring ? R.string.localizable.restorePasswordTitle() : R.string.localizable.newPasswordTitle()
        
        form +++ Section()
            <<< GenericPasswordRow {
                $0.onChange {
                    self.password = $0.value
                    self.navigationItem.rightBarButtonItem?.isEnabled = $0.isPasswordValid()
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func continuePressed(_ sender: UIButton) {
        sender.loadingIndicator(true)
        if restoring {
            accountService.restoreAccount(passphrase: password)
        } else {
            accountService.createAccount(passphrase: password)
        }
    }
}


// MARK: - EthereumAccountDelegate

extension PasswordViewController: EthereumAccountDelegate {
    
    func success(account: Account) {
        Wallet.createWithAddress(account.address)
        Defaults.isAuthorized = true
        continueButton.loadingIndicator(false)
        performSegue(withIdentifier: R.segue.passwordViewController.goToWallet.identifier, sender: nil)
    }
    
    func didFailed(with error: Error) {
        continueButton.loadingIndicator(false)
        error.showAllertIfNeeded(from: self)
    }
}
