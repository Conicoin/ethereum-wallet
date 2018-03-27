//
//  TransactionHeaderCell.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 26/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class TransactionHeaderCell: UITableViewCell {
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var dayAmountLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
