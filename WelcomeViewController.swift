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
    @IBOutlet weak var restoreWalletButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newWalletButton.layer.cornerRadius = 5
        restoreWalletButton.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
