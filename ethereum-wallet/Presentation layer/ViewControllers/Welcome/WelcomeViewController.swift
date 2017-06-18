//
//  WelcomeViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 15/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var newWalletButton: UIButton!
    
    var isRestoringAvailable: Bool {
        return Keychain.isAccountBackuped
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonTitle = isRestoringAvailable ? R.string.localizable.welcomeRestoreTitle() : R.string.localizable.welcomeNewTitle()
        newWalletButton.setTitle(buttonTitle, for: .normal)
        newWalletButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
