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
    
    @IBOutlet weak var continueButton: UIBarButtonItem!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Account creation"
                
        form +++ Section()
            <<< GenericPasswordRow {
                $0.onChange {
                    self.navigationItem.rightBarButtonItem?.isEnabled = $0.isPasswordValid()
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
