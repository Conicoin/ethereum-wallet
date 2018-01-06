// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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


class CoinDetailsViewController: UIViewController {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!

  var output: CoinDetailsViewOutput!


  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
  
  // MARK: Actions
  
  @IBAction func sendPressed(_ sender: UIButton) {
    output.didSendPressed()
  }
  
  @IBAction func receivePressed(_ sender: UIButton) {
    output.didReceivePressed()
  }

}


// MARK: - CoinDetailsViewInput

extension CoinDetailsViewController: CoinDetailsViewInput {
    
  func setupInitialState() {
    
  }
    
  func didReceiveCoin(_ coin: Coin) {
    let placeholder = coin.placeholder(with: iconImageView.bounds.size)
    iconImageView.kf.setImage(with: coin.iconUrl, placeholder: placeholder)
    balanceLabel.text = Localized.coinDetailsBalance(coin.balance.amount)
    nameLabel.text = coin.balance.name
    symbolLabel.text = coin.balance.iso
  }

}
