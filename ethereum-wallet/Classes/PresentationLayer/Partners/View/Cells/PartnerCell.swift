// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

class PartnerCell: UITableViewCell {
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var symbolLabel: UILabel!
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var fundedLabel: UILabel!
  @IBOutlet var fundProgress: UIProgressView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
