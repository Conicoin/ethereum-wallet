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
    navigationController?.setNavigationBarHidden(true, animated: animated)
    output.viewIsAppear()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
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
    let counts = [output.coins.count, output.tokens.count]
    return counts[section]
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(CoinCell.self, for: indexPath)
    let coins = [output.coins, output.tokens] as [[CoinDisplayable]]
    let coin = coins[indexPath.section][indexPath.row]
    cell.configure(with: coin, localCurrency: output.localCurrency)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let view = collectionView.dequeue(CoinHeader.self, kind: kind, for: indexPath)!
    let chainTitle = output.chain.localizedDescription.uppercased()
    let titles = [Localized.balanceEtherTitle(), Localized.balanceCoinsTitle()]
    let subtitles = [chainTitle, Localized.balanceCoinsSubtitle()]
    view.subtitleLabel.text = subtitles[indexPath.section]
    view.titleLabel.text = titles[indexPath.section]
    return view
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      output.didSelectCoin(at: indexPath.row)
    } else {
      output.didSelectToken(at: indexPath.row)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width, height: CoinCell.cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)!
    cell.alpha = 0.5
  }
  
  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)!
    cell.alpha = 1
  }
  
}


// MARK: - BalanceViewInput

extension BalanceViewController: BalanceViewInput {
  
  func setupInitialState() {

  }
  
  func didReceiveWallet() {
    collectionView.reloadData()
  }
  
  func didReceiveTokens() {
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
