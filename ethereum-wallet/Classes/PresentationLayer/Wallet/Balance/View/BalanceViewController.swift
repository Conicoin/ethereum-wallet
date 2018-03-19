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


class BalanceViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var receiveButton: UIButton!
  @IBOutlet weak var receiveLabel: UILabel!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var sendLabel: UILabel!
  @IBOutlet weak var tokenCountLabel: UILabel!
  @IBOutlet weak var tokenBalanceLabel: UILabel!
    
  var output: BalanceViewOutput!
  
  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
    output.viewIsAppear()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  // MARK: - Privates
  
  private func setupTableView() {
    let tableWidth = view.bounds.width
    let size = CGSize(width: tableWidth, height: tableWidth+50)
    tableView.tableHeaderView?.frame = CGRect(origin: .zero, size: size)
    tableView.contentInsetAdjustmentBehavior = .never
//    tableView.tableHeaderView?.layer.zPosition = 0
    tableView.backgroundColor = Theme.Color.lightGray
  }
  
  // MARK: - Actions
  
  @objc func refresh(_ sender: UIRefreshControl) {
    output.didRefresh()
  }
  
}

// MARK: - TableView

extension BalanceViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(TokenCell.self, for: indexPath)
    cell.configure(with: output.tokens[indexPath.row])
    cell.layer.zPosition = 1
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return output.tokens.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 184
  }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    output.didSelectToken(at: indexPath.row)
  }

}


// MARK: - BalanceViewInput

extension BalanceViewController: BalanceViewInput {
  
  func setupInitialState() {
  }
  
  func didReceiveWallet() {

  }
  
  func didReceiveTokens() {
    tableView.reloadData()
  }
  
  func didReceiveCoins() {

  }
  
  func stopRefreshing() {
    tableView.refreshControl?.endRefreshing()
  }
  
  func syncDidChangeProgress(current: Float, total: Float) {
  }
  
  func syncDidFinished() {
  }

}
