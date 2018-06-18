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
  @IBOutlet weak var sendButtonLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var tableHeight: NSLayoutConstraint!

  var output: TokenDetailsViewOutput!
  var transactions = [TransactionDisplayer]()
  let cellHeight: CGFloat = 76
  
  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    localize()
    scrollView.delegate = self
    scrollView.setupBorder()
    tableView.registerNib(TransactionCell.self)
    output.viewIsReady()
  }
  
  // MARK: Privates
  
  func localize() {
    addressTitleLabel.text = Localized.tokenDetailsAddress()
    holdersTitleLabel.text = Localized.tokenDetailsHolders()
    supplyTitleLabel.text = Localized.tokenDetailsSupply()
    descTitleLabel.text = Localized.tokenDetailsDesc()
    sendButtonLabel.text = Localized.tokenDetailsSend()
  }
  
  // MARK: Actions
  
  @IBAction func sendPressed(_ sender: UIButton) {
    output.didSendPressed()
  }
  
  @IBAction func balanceViewPressed(_ sender: UITapGestureRecognizer) {
    output.didBalanceViewPressed()
  }
  
}


// MARK: - TokenDetailsViewInput

extension TokenDetailsViewController: TokenDetailsViewInput {
    
  func setupInitialState() {

  }
  
  func didReceiveToken(_ token: Token) {
    balanceLabel.text = token.balance.amountString
    fiatBalanceLabel.text = token.description
  
    addressLabel.text = token.address
  }
  
  func didReceiveFiatBalance(_ balance: String) {
    fiatBalanceLabel.text = balance
  }
  
  func didReceiveTransactions(_ transactions: [TransactionDisplayer]) {
    self.transactions = transactions
    tableView.reloadData()
    tableHeight.constant = cellHeight * CGFloat(transactions.count)
    view.layoutIfNeeded()
  }

}


// MARK: - UIScrollViewDelegate

extension TokenDetailsViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    navigationItem.titleView?.alpha = scrollView.contentOffset.y
  }
  
}

// MARK: - Table View

extension TokenDetailsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(TransactionCell.self, for: indexPath)
    cell.configure(with: transactions[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return transactions.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeight
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    output.didTransactionPressed(transactions[indexPath.row])
  }
  
}
