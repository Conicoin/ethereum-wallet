// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit
import PullToDismiss


class TransactionDetailsViewController: UIViewController {
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var timeLabel: UILabel!
  @IBOutlet var statusLabel: UILabel!
  @IBOutlet var statusImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var amountLabel: UILabel!
  @IBOutlet var txHashTitleLabel: UILabel!
  @IBOutlet var txHashLabel: UILabel!
  @IBOutlet var blockHeightTitleLabel: UILabel!
  @IBOutlet var blockHeightLabel: UILabel!
  @IBOutlet var fromTitleLabel: UILabel!
  @IBOutlet var fromLabel: UILabel!
  @IBOutlet var toTitleLabel: UILabel!
  @IBOutlet var toLabel: UILabel!
  @IBOutlet var spentTitleLabel: UILabel!
  @IBOutlet var spentLabel: UILabel!
  @IBOutlet var feeTitleLabel: UILabel!
  @IBOutlet var feeLabel: UILabel!
  @IBOutlet var etherscanButton: UIButton!
  @IBOutlet var feeView: UIView!
  @IBOutlet var spentView: UIView!
  @IBOutlet var blockHeightView: UIView!
  
  
  var output: TransactionDetailsViewOutput!
  private var pullToDismiss: PullToDismiss!


  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    localize()
    setupPullToDismiss()
    output.viewIsReady()
  }
  
  // MARK: Privates
  
  private func setupPullToDismiss() {
    pullToDismiss = PullToDismiss(scrollView: scrollView)
    pullToDismiss.delegate = self
    pullToDismiss.edgeShadow = nil
    pullToDismiss.backgroundEffect = ShadowEffect(color: .white, alpha: 0.9)
  }
  
  private func localize() {
    txHashTitleLabel.text = Localized.txDetailsTxHash()
    blockHeightTitleLabel.text = Localized.txDetailsBlockHeight()
    fromTitleLabel.text = Localized.txDetailsFrom()
    toTitleLabel.text = Localized.txDetailsTo()
    spentTitleLabel.text = Localized.txDetailsSpent()
    feeTitleLabel.text = Localized.txDetailsFee()
    statusLabel.text = Localized.txDetailsCompleted()
    etherscanButton.setTitle(Localized.txDetailsEtherscan(), for: .normal)
  }
  
  // MARK: Actions
  
  @IBAction func etherscanPressed(_ sender: UIButton) {
    output.didEtherscanPressed()
  }

}


// MARK: - TransactionDetailsViewInput

extension TransactionDetailsViewController: TransactionDetailsViewInput {
    
  func setupInitialState() {

  }
  
  func didReceiveTransaction(_ displayer: TransactionDisplayer) {
    statusImageView.image = UIImage(named: displayer.imageName)
    titleLabel.text = displayer.title
    timeLabel.text = displayer.tx.timeStamp.detailed()
    amountLabel.text = displayer.amountString
    
    if let status = displayer.status {
      statusLabel.text = status
    }
    
    txHashLabel.text = displayer.tx.txHash
    fromLabel.text = displayer.tx.from
    toLabel.text = displayer.tx.to
    spentLabel.text = displayer.tx.amount.amountString
    spentLabel.text = displayer.totalAmount
    feeLabel.text = displayer.fee
    spentView.isHidden = displayer.isTokenTransfer
    blockHeightView.isHidden = displayer.isTokenTransfer
  }

}


// MARK: - UIScrollViewDelegate

extension TransactionDetailsViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
  }
  
}
