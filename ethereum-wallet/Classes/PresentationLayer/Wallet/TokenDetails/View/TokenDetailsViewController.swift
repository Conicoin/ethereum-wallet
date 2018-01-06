//
//  TokenDetailsTokenDetailsViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class TokenDetailsViewController: UIViewController {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var descriptionView: UIView!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var totalSuplyLabel: UILabel!
  @IBOutlet weak var holdersCountLabel: UILabel!

  var output: TokenDetailsViewOutput!
  
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


// MARK: - TokenDetailsViewInput

extension TokenDetailsViewController: TokenDetailsViewInput {
    
  func setupInitialState() {

  }
  
  func didReceiveToken(_ token: Token) {
    balanceLabel.text = Localized.tokenDetailsBalance(token.balance.amount)
    nameLabel.text = token.balance.name
    symbolLabel.text = token.balance.iso
    if let iconUrl = token.iconUrl {
      let placeholder = token.placeholder(with: iconImageView.bounds.size)
      iconImageView.kf.setImage(with: iconUrl, placeholder: placeholder)
    }
    if let description = token.about {
      descriptionView.isHidden = false
      descriptionTextView.text = description
    }
    addressLabel.text = token.address
    let totalSuply = Decimal(token.totalSupply)
    totalSuplyLabel.text = "\(totalSuply.abbrevation()) \(token.balance.iso)"
    holdersCountLabel.text = "\(token.holdersCount!)"
  }

}
