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
  @IBOutlet weak var syncButton: UIBarButtonItem!
  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  var output: BalanceViewOutput!
  
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
  
  // MARK: - Privates
  
  private func setupPullToRefresh() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    collectionView.refreshControl = refreshControl
  }
  
  // MARK: - Actions
  
  @objc func refresh(_ sender: UIRefreshControl) {
    output.didRefresh()
  }
  
}

// MARK: - TableView

extension BalanceViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return output.coins.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCell", for: indexPath) as! CoinCell
    cell.configure(with: output.coins[indexPath.row], localCurrency: output.localCurrency)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CoinHeader", for: indexPath) as! CoinHeader
    view.subtitleLabel.text = output.chain.localizedDescription.uppercased()
    view.titleLabel.text = Localized.balanceEtherTitle()
    return view
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width, height: 142)
  }
  
}


// MARK: - BalanceViewInput

extension BalanceViewController: BalanceViewInput {
  
  func setupInitialState() {

  }
  
  func didReceiveWallet() {
    collectionView.reloadData()
  }
  
  func didReceiveCoins() {
    collectionView.refreshControl?.endRefreshing()
    collectionView.reloadData()
  }
  
  func stopRefreshing() {
    collectionView.refreshControl?.endRefreshing()
  }
  
  func syncDidChangeProgress(current: Float, total: Float) {
    progressView.setProgress(current/total, animated: true)
    syncButton.title = "\(Int(current))/\(Int(total))"
    UIApplication.shared.isIdleTimerDisabled = true
  }
  
  func syncDidFinished() {
    progressView.setProgress(0, animated: false)
    syncButton.title = nil
    UIApplication.shared.isIdleTimerDisabled = false
  }

}
