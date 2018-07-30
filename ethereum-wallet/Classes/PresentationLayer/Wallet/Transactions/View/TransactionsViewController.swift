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
import SafariServices
import Dwifft

class TransactionsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var output: TransactionsViewOutput!
  
  var diffCalculator: TableViewDiffCalculator<Date, TransactionDisplayer>!
  private var transactions = [TransactionDisplayer]()
  
  private var refresh = UIRefreshControl()
  private var bottomLoader: UIActivityIndicatorView!
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    localize()
    setupDiffCalculator()
    setupTableView()
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    output.viewIsAppear()
  }
  
  // MARK: Privates
  
  private func localize() {
    navigationItem.title = Localized.transactionsTitle()
  }
  
  private func setupTableView() {
    tableView.setupBorder()
    tableView.refreshControl = refresh
    tableView.registerNib(TransactionCell.self)
    bottomLoader = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    bottomLoader.hidesWhenStopped = true
    tableView.tableFooterView = bottomLoader
    refresh.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
  }
  
  private func setupDiffCalculator() {
    diffCalculator = TableViewDiffCalculator(tableView: tableView)
    diffCalculator.deletionAnimation = .fade
    diffCalculator.insertionAnimation = .fade
  }
  
  @objc func refresh(_ sender: UIRefreshControl) {
    output.didRefresh()
  }
  
  func loadNextPage() {
    bottomLoader.startAnimating()
    output.loadNextPage()
  }
}


// MARK: - TransactionsViewInput

extension TransactionsViewController: TransactionsViewInput {
  
  func setTransactions(_ transactions: [TransactionDisplayer]) {
    self.transactions = transactions
    diffCalculator.sectionedValues = {
      return SectionedValues<Date, TransactionDisplayer>(values: transactions, valueToSection: { tx in
        return Calendar.current.startOfDay(for: tx.time)
      }, sortSections: { $0 > $1 }, sortValues: { $0.time > $1.time })
    }()
  }
  
  func setupInitialState() {
    
  }
  
  func stopRefreshing() {
    refresh.endRefreshing()
    bottomLoader.stopAnimating()
  }
  
}

// MARK: - Table View

extension TransactionsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(TransactionCell.self, for: indexPath)
    let transaction = diffCalculator.value(atIndexPath: indexPath)
    cell.configure(with: transaction)
  
    let sectionsCount = diffCalculator.numberOfSections()
    let transactionsCount = diffCalculator.numberOfObjects(inSection: indexPath.section)
    let isLast = indexPath.section == sectionsCount-1 && indexPath.row == transactionsCount-1
    if isLast {
      loadNextPage()
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeue(TransactionHeaderCell.self)
    let sectionKey = diffCalculator.value(forSection: section)
    header.timeLabel.text = sectionKey.humanReadable()
    // returning contentView is a workaround: section headers disappear when using -performBatchUpdates
    // https://stackoverflow.com/questions/30149551/tableview-section-headers-disappear-swift
    return header.contentView
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return diffCalculator.numberOfObjects(inSection: section)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return diffCalculator.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 76
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 52
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let transaction = diffCalculator.value(atIndexPath: indexPath)
    output.didTransactionPressed(transaction)
  }
  
}

