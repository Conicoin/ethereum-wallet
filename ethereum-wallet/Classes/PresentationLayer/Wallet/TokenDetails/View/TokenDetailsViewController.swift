// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class TokenDetailsViewController: UIViewController {
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var fiatBalanceLabel: UILabel!
  @IBOutlet var balanceLabel: UILabel!
  @IBOutlet var descriptionView: UIView!
  @IBOutlet var descriptionTextView: UITextView!
  @IBOutlet var addressLabel: UILabel!
  @IBOutlet var totalSuplyLabel: UILabel!
  @IBOutlet var holdersCountLabel: UILabel!
  @IBOutlet var addressTitleLabel: UILabel!
  @IBOutlet var holdersTitleLabel: UILabel!
  @IBOutlet var supplyTitleLabel: UILabel!
  @IBOutlet var descTitleLabel: UILabel!
  @IBOutlet var sendButtonLabel: UILabel!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var tableHeight: NSLayoutConstraint!
  
  var output: TokenDetailsViewOutput!
  var transactions = [TransactionDisplayer]()
  let cellHeight: CGFloat = 76
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    localize()
    customize()
    scrollView.delegate = self
    scrollView.setupBorder()
    tableView.registerNib(TransactionCell.self)
    output.viewIsReady()
  }
  
  // MARK: Privates
  
  private func customize() {
    balanceLabel.adjustsFontSizeToFitWidth = true
    balanceLabel.minimumScaleFactor = 0.7
  }
  
  private func localize() {
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
  
  func didReceiveToken(_ viewModel: TokenViewModel) {
    balanceLabel.text = viewModel.amountString()
    fiatBalanceLabel.text = viewModel.description()
    
    addressLabel.text = viewModel.token.address
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
