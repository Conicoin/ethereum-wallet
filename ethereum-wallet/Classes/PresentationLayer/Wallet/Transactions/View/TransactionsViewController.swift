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
import RealmSwift
import SafariServices
import SpringIndicator

class TransactionsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!

  var output: TransactionsViewOutput!
  
  private var refresh: RefreshIndicator!
  private var sections = [Date: [TransactionDisplayer]]()
  private var sortedSections = [Date]()
  private var localCurrency = Constants.Wallet.defaultCurrency

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    output.viewIsAppear()
  }
  
  private func setupTableView() {
    tableView.setupBorder()
    refresh = tableView.setupRefresh(target: self, selector: #selector(refresh(_:)))
  }
    
  @objc func refresh(_ sender: UIControl) {
    let generator = UISelectionFeedbackGenerator()
    generator.selectionChanged()
    output.didRefresh()
  }

}


// MARK: - TransactionsViewInput

extension TransactionsViewController: TransactionsViewInput {
  
  func setupInitialState() {

  }
  
  func didReceiveWallet(_ wallet: Wallet) {
    self.localCurrency = wallet.localCurrency
  }
  
  func didReceiveSections(_ sections: [Date: [TransactionDisplayer]], sortedSections: [Date]) {
    self.sections = sections
    self.sortedSections = sortedSections
    tableView.reloadData()
  }
  
  func stopRefreshing() {
    refresh.endRefreshing()
  }

}

// MARK: - Table View

extension TransactionsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(TransactionCell.self, for: indexPath)
    let section = sortedSections[indexPath.section]
    cell.configure(with: sections[section]![indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeue(TransactionHeaderCell.self)
    let sectionKey = sortedSections[section]
    header.timeLabel.text = sectionKey.humanReadable()
    return header
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[sortedSections[section]]!.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sortedSections.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 76
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 52
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let sectionKey = sortedSections[indexPath.section]
    let transactions = sections[sectionKey]!
    output.didTransactionPressed(transactions[indexPath.row])
  }
  
}
