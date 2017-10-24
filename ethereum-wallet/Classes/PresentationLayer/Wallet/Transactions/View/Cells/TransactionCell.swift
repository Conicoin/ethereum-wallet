//
//  TransactionCell.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 24/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
