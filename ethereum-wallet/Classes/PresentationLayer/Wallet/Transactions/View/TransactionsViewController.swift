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

class TransactionsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!

  var output: TransactionsViewOutput!
  
  private var refresh = UIRefreshControl()
  private var bottomLoader: UIActivityIndicatorView!
  private var data = TransactionsDisplayerContainer()

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    localize()
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
  
  func setupInitialState() {

  }
  
  func didReceiveSections(_ sections: TransactionsDisplayerContainer) {
    self.data = sections
    tableView.reloadData()
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
    let section = data.sections[indexPath.section]
    cell.configure(with: section.transactions[indexPath.row])
    
    let isLast = indexPath.section == data.sections.count-1 && indexPath.row == section.transactions.count-1
    if isLast {
      loadNextPage()
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeue(TransactionHeaderCell.self)
    let sectionKey = data.sections[section].date
    header.timeLabel.text = sectionKey.humanReadable()
    return header
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.sections[section].transactions.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return data.sections.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 76
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 52
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let transaction = data.sections[indexPath.section].transactions[indexPath.row]
    output.didTransactionPressed(transaction)
  }
  
}

