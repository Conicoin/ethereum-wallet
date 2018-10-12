//
//  PartnerCell.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 07/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
