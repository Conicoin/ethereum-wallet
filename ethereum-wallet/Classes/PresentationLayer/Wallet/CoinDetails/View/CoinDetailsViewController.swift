//
//  CoinDetailsCoinDetailsViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class CoinDetailsViewController: UIViewController {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!

  var output: CoinDetailsViewOutput!


  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
  
  // MARK: Actions
  
  @IBAction func sendPressed(_ sender: UIButton) {
    output.didSendPressed()
  }
  
  @IBAction func receivePressed(_ sender: UIButton) {
    output.didReceivePressed()
  }

}


// MARK: - CoinDetailsViewInput

extension CoinDetailsViewController: CoinDetailsViewInput {
    
  func setupInitialState() {
    
  }
    
  func didReceiveCoin(_ coin: Coin) {
    let placeholder = coin.placeholder(with: iconImageView.bounds.size)
    iconImageView.kf.setImage(with: coin.iconUrl, placeholder: placeholder)
    balanceLabel.text = Localized.coinDetailsBalance(coin.balance.amount)
    nameLabel.text = coin.balance.name
    symbolLabel.text = coin.balance.iso
  }

}
