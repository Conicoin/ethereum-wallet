// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

class ChooseCurrencyCell: UITableViewCell {
  
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet var isoLabel: UILabel!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var checkmarkImageView: UIImageView!

  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    checkmarkImageView.image = selected ? #imageLiteral(resourceName: "CheckMin") : nil
    isoLabel.textColor = selected ? Theme.Color.blue : Theme.Color.gray
    nameLabel.textColor = selected ? Theme.Color.blue : Theme.Color.gray
  }
  
  func configure(with currency: FiatCurrency) {
    iconImageView.image = currency.icon
    isoLabel.text = currency.iso
    nameLabel.text = currency.name
  }
  
}
