// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import UIKit

class TransactionCell: UITableViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func configure(with displayer: TransactionDisplayer) {
    
    titleLabel.text = displayer.title
    
    amountLabel.text = displayer.amountString
    
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm"
    var description = formatter.string(from: displayer.tx.timeStamp)
    
    if let status = displayer.status {
      description += ",\(status)"
    }
    
    descriptionLabel.text = description
    iconImageView.image = UIImage(named: displayer.imageName)
  }
  
}
