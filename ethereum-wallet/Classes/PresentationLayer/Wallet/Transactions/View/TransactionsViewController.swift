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
import RealmSwift

class TransactionsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!

  var output: TransactionsViewOutput!
  var transactions = [Transaction]()
  

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
    setupPullToRefresh()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    output.viewIsAppear()
  }
  
  private func setupPullToRefresh() {
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
    tableView.refreshControl = refresh
  }
    
  @objc func refresh(_ sender: UIRefreshControl) {
    output.didRefresh()
  }

}


// MARK: - TransactionsViewInput

extension TransactionsViewController: TransactionsViewInput {
  
  func setupInitialState() {

  }
  
  func didReceiveTransactions(_ transactions: [Transaction]) {
    self.transactions = transactions
    tableView.reloadData()
    tableView.refreshControl?.endRefreshing()
  }
  
  func stopRefreshing() {
    tableView.refreshControl?.endRefreshing()
  }

}

// MARK: - Table View

extension TransactionsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
    cell.configure(with: transactions[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return transactions.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
