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

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupPullToRefresh()
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    output.viewIsAppear()
  }
  
  private func showAlert(for index: Int) {
    let alert = UIAlertController(title: Localized.transactionsAlertTitle(), message: nil, preferredStyle: .alert)

    let ok = UIAlertAction(title: Localized.transactionsAlertOk(), style: .default) { action in
      let transaction = self.output.filteredTransactions[index]
      let urlString = Defaults.chain.etherscanUrl + "/tx/\(transaction.txHash!)"
      guard let url = URL(string: urlString) else { return }
      let svc = SFSafariViewController(url: url)
      self.present(svc, animated: true, completion: nil)
    }
    let cancel = UIAlertAction(title: Localized.transactionsAlertCancel(), style: .default, handler: nil)
    alert.addAction(cancel)
    alert.addAction(ok)
    present(alert, animated: true, completion: nil)
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
  
  func didReceiveTransactions() {
    tableView.reloadData()
  }
  
  func stopRefreshing() {
    tableView.refreshControl?.endRefreshing()
  }

}

// MARK: - Table View

extension TransactionsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(TransactionCell.self, for: indexPath)
    cell.configure(with: output.filteredTransactions[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return output.filteredTransactions.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    showAlert(for: indexPath.row)
  }
  
}
