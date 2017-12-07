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


class BalanceViewController: UIViewController {
  @IBOutlet weak var coinsView: UIView!
  @IBOutlet weak var syncButton: UIBarButtonItem!
  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var receiveButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
  
  var output: BalanceViewOutput!
  private var coins = [Coin]()
  private var localCurrency = Constants.Wallet.defaultCurrency
  
  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    output.viewIsAppear()
  }
  
  // MARK: - Privates
  
  // MARK: - Actions
  
  @IBAction func sendPressed(_ sender: UIButton) {
    output.sendButtonPressed()
  }
  
  @IBAction func receivePressed(_ sender: UIButton) {
    output.receiveButtonPressed()
  }
  
}

// MARK: - TableView

extension BalanceViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as! CoinCell
    cell.configure(with: coins[indexPath.row], localCurrency: localCurrency)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return coins.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 64
  }
  
}


// MARK: - BalanceViewInput

extension BalanceViewController: BalanceViewInput {
  
  func setupInitialState() {

  }
  
  func didReceiveWallet(_ wallet: Wallet) {
    self.localCurrency = wallet.localCurrency
    tableView.reloadData()
  }
  
  func didReceiveCoins(_ coins: [Coin]) {
    self.coins = coins
    tableView.reloadData()
    view.layoutIfNeeded()
    tableViewHeightConstraint.constant = tableView.contentSize.height
    view.layoutIfNeeded()
    coinsView.isHidden = false
  }
  
  func syncDidChangeProgress(current: Float, total: Float) {
    progressView.setProgress(current/total, animated: true)
    syncButton.title = "\(Int(current))/\(Int(total))"
    UIApplication.shared.isIdleTimerDisabled = true
  }
  
  func syncDidFinished() {
    progressView.setProgress(0, animated: false)
    syncButton.title = nil
    sendButton.isHidden = false
    UIApplication.shared.isIdleTimerDisabled = false
  }

}
