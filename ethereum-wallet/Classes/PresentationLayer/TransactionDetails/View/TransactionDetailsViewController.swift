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

  var output: TransactionDetailsViewOutput!
  private var pullToDismiss: PullToDismiss!


  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupPullToDismiss()
    output.viewIsReady()
  }
  
  // MARK: Privates
  
  func setupPullToDismiss() {
    pullToDismiss = PullToDismiss(scrollView: scrollView)
    pullToDismiss.delegate = self
    pullToDismiss.backgroundEffect = ShadowEffect(color: .white, alpha: 0.97)
  }

}


// MARK: - TransactionDetailsViewInput

extension TransactionDetailsViewController: TransactionDetailsViewInput {
    
  func setupInitialState() {

  }

}


// MARK: - UIScrollViewDelegate

extension TransactionDetailsViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
  }
  
}
