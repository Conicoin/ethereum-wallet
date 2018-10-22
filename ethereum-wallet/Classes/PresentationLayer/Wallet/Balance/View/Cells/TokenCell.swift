// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class TokenCell: UITableViewCell {
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var symbolLabel: UILabel!
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet var balanceLabel: UILabel!
  @IBOutlet var tokenBackgroundView: UIView!
  
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
  
  func configure(with viewModel: TokenViewModel) {
    titleLabel.text = viewModel.token.balance.name
    symbolLabel.text = viewModel.token.balance.symbol
    balanceLabel.text = viewModel.token.balance.amountString
    
    // Attention! Need to monitor icons location
    iconImageView.image = UIImage(named: "../token-icons/images/\(viewModel.token.address)")
  }
  
}
