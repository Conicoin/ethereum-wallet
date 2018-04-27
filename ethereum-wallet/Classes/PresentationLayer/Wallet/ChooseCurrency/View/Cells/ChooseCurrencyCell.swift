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

class ChooseCurrencyCell: UITableViewCell {
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var isoLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var checkmarkImageView: UIImageView!

  
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
