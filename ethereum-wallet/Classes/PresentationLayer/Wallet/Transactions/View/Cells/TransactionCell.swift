// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

class TransactionCell: UITableViewCell {
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var amountLabel: UILabel!
  @IBOutlet var errorLineView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    amountLabel.adjustsFontSizeToFitWidth = true
    amountLabel.minimumScaleFactor = 0.9
  }
  
  func configure(with displayer: TransactionDisplayer) {
    
    titleLabel.text = displayer.title
    
    amountLabel.text = displayer.amountString
    
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .none
    var description = formatter.string(from: displayer.tx.timeStamp)
    
    if let status = displayer.status {
      description += ", \(status)"
      amountLabel.textColor = Theme.Color.gray
    }
    
    descriptionLabel.text = description
    iconImageView.image = UIImage(named: displayer.imageName)
    errorLineView.isHidden = !displayer.isError
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    amountLabel.textColor = Theme.Color.black
  }
  
}
