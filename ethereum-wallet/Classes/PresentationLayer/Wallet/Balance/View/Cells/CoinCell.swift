//  MIT License
//
//  Copyright (c) 2018 Artur Guseinov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.A

import UIKit
import Kingfisher

class CoinCell: UICollectionViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var isoLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var coloredView: UIView!
  @IBOutlet weak var localBalanceLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!
  
  static var cellHeight: CGFloat = 142
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    localBalanceLabel.text = "-"
  }
  
  func configure(with coin: CoinDisplayable, localCurrency: String) {
    nameLabel.text = coin.balance.name
    isoLabel.text = coin.balance.iso
    balanceLabel.text = coin.balance.amount
    coloredView.backgroundColor = coin.color
    
    if let rate = coin.rates.filter({ $0.to == localCurrency }).first {
      localBalanceLabel.text = coin.balance.amount(in: localCurrency, rate: rate.value)
    }

    let placeholder = coin.placeholder(with: iconImageView.bounds.size)
    iconImageView.kf.setImage(with: coin.iconUrl, placeholder: placeholder)
    iconImageView.tintColor = coin.color
  }
  
}
