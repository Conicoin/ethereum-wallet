//
//  BalanceBalanceViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class BalanceViewController: UIViewController {

  var output: BalanceViewOutput!


  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }

}


// MARK: - BalanceViewInput

extension BalanceViewController: BalanceViewInput {
    
  func setupInitialState() {

  }

}
