//
//  TransactionCell.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import DTTableViewManager
import DTModelStorage

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


// MARK: - ModelTransfer

extension TransactionCell: ModelTransfer {
    
    func update(with model: Transaction) {
        label.text = model.txHash
    }
    
}
