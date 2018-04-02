//
//  TransactionDetailsTransactionDetailsViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 01/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit
import PullToDismiss


class TransactionDetailsViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var statusImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var txHashTitleLabel: UILabel!
  @IBOutlet weak var txHashLabel: UILabel!
  @IBOutlet weak var blockHeightTitleLabel: UILabel!
  @IBOutlet weak var blockHeightLabel: UILabel!
  @IBOutlet weak var fromTitleLabel: UILabel!
  @IBOutlet weak var fromLabel: UILabel!
  @IBOutlet weak var toTitleLabel: UILabel!
  @IBOutlet weak var toLabel: UILabel!
  @IBOutlet weak var spentTitleLabel: UILabel!
  @IBOutlet weak var spentLabel: UILabel!
  @IBOutlet weak var feeTitleLabel: UILabel!
  @IBOutlet weak var feeLabel: UILabel!
  @IBOutlet weak var etherscanButton: UIButton!
  @IBOutlet weak var feeView: UIView!
  @IBOutlet weak var spentView: UIView!
  @IBOutlet weak var blockHeightView: UIView!
  
  
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
  
  func didReceiveTxIndex(_ txIndex: TxIndex) {
    statusImageView.image = UIImage(named: txIndex.imageName)
    titleLabel.text = txIndex.title
    timeLabel.text = txIndex.time.detailed()
    amountLabel.text = txIndex.amount
    
    if let status = txIndex.status {
      statusLabel.text = status
    }
  }
  
  func didReceiveTransaction(_ transaction: TransactionDisplayable) {
    txHashLabel.text = transaction.txHash
    fromLabel.text = transaction.from
    toLabel.text = transaction.to
    spentLabel.text = transaction.amount.amountString
    spentLabel.text = transaction.totalAmount
    feeLabel.text = transaction.fee
    feeView.isHidden = transaction.isTokenTransfer
    spentView.isHidden = transaction.isTokenTransfer
    blockHeightView.isHidden = transaction.isTokenTransfer
  }

}


// MARK: - UIScrollViewDelegate

extension TransactionDetailsViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
  }
  
}
