//
//  BalanceBalanceViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class BalanceViewController: UIViewController {
  @IBOutlet weak var loadingButton: UIButton!
  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!

  var output: BalanceViewOutput!
  

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
    loadingButton.loadingIndicator(true)
  }

}


// MARK: - BalanceViewInput

extension BalanceViewController: BalanceViewInput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    balanceLabel.text = wallet.balance.toEtherString()
    addressLabel.text = wallet.address
  }
    
  func setupInitialState() {
    
  }
  
  func syncDidChangeProgress(current: Float, total: Float) {
    progressView.setProgress(current/total, animated: true)
  }
  
  func syncDidFinished() {
    progressView.setProgress(0, animated: false)
    loadingButton.loadingIndicator(false)
  }

}
