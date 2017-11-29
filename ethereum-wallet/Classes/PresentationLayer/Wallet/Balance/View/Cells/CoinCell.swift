//  MIT License
//
//  Copyright (c) 2017 Artur Guseinov
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

class CoinCell: UITableViewCell {
  
  @IBOutlet weak var coinImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var localAmountLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    coinImageView.layer.cornerRadius = 10
    coinImageView.layer.borderColor = Theme.Color.gray.withAlphaComponent(0.5).cgColor
    coinImageView.layer.borderWidth = 0.5
    coinImageView.layer.masksToBounds = true
  }
  
  func configure(with coin: Coin, localCurrency: String) {
    coinImageView.image = UIImage(named: coin.balance.name)
    nameLabel.text = coin.balance.name
    amountLabel.text = coin.balance.amount
    
    if let rate = coin.rates.filter({ $0.to == localCurrency }).first {
      localAmountLabel.text = coin.balance.amount(in: localCurrency, rate: rate.value)
    }
  }
  
}
