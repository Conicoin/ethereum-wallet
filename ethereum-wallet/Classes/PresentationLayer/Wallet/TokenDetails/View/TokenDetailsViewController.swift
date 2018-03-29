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


class TokenDetailsViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var fiatBalanceLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var descriptionView: UIView!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var totalSuplyLabel: UILabel!
  @IBOutlet weak var holdersCountLabel: UILabel!
  @IBOutlet weak var addressTitleLabel: UILabel!
  @IBOutlet weak var holdersTitleLabel: UILabel!
  @IBOutlet weak var supplyTitleLabel: UILabel!
  @IBOutlet weak var descTitleLabel: UILabel!
  @IBOutlet weak var infoTitleLabel: UILabel!
  @IBOutlet weak var sendButtonLabel: UILabel!

  var output: TokenDetailsViewOutput!
  
  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    localize()
    scrollView.delegate = self
    scrollView.setupBorder()
    output.viewIsReady()
  }
  
  // MARK: Privates
  
  func localize() {
    addressTitleLabel.text = Localized.tokenDetailsAddress()
    holdersTitleLabel.text = Localized.tokenDetailsHolders()
    supplyTitleLabel.text = Localized.tokenDetailsSupply()
    descTitleLabel.text = Localized.tokenDetailsDesc()
    infoTitleLabel.text = Localized.tokenDetailsInfo()
    sendButtonLabel.text = Localized.tokenDetailsSend()
  }
  
  // MARK: Actions
  
  @IBAction func sendPressed(_ sender: UIButton) {
    output.didSendPressed()
  }
  
}


// MARK: - TokenDetailsViewInput

extension TokenDetailsViewController: TokenDetailsViewInput {
    
  func setupInitialState() {

  }
  
  func didReceiveToken(_ token: Token) {
    balanceLabel.text = token.balance.amountString
    navigationItem.title = Localized.tokenDetailsName(token.balance.symbol, token.balance.name)
  
    if let description = token.about {
      descriptionView.isHidden = false
      descriptionTextView.text = description
    }
    addressLabel.text = token.address
    let totalSuply = Decimal(token.totalSupply)
    totalSuplyLabel.text = "\(totalSuply.abbrevation()) \(token.balance.iso)"
    holdersCountLabel.text = "\(token.holdersCount!)"
  }
  
  func didReceiveFiatBalance(_ balance: String) {
    fiatBalanceLabel.text = balance
  }

}


// MARK: - UIScrollViewDelegate

extension TokenDetailsViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    navigationItem.titleView?.alpha = scrollView.contentOffset.y
  }
  
}
