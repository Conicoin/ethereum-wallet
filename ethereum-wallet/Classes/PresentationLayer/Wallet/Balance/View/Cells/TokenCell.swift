//
//  TokenCell.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class TokenCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var tokenBackgroundView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    tokenBackgroundView.backgroundColor = highlighted ? Theme.Color.lightGray : .white
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    iconImageView.image = nil
  }
  
  func configure(with token: Token) {
    titleLabel.text = token.balance.name
    symbolLabel.text = token.balance.symbol
    balanceLabel.text = token.balance.amountString
    
    // Attention! Need to monitor icons location
    iconImageView.image = UIImage(named: "images/\(token.address!)")
  }
  
}
