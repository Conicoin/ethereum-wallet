//
//  SendTokenSendTokenViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class SendTokenViewController: UIViewController, ShadowHidable {
  @IBOutlet weak var addressTextField: UITextField!
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var gasLimitTextField: UITextField!
  @IBOutlet weak var scanQRButton: UIButton!
  @IBOutlet weak var currencyLabel: UILabel!
  @IBOutlet weak var gasPriceLabel: UILabel!
  @IBOutlet weak var localFeeLabel: UILabel!
  @IBOutlet weak var feeLabel: UILabel!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var keyboardConstraint: NSLayoutConstraint!

  var output: SendTokenViewOutput!
  var shadowImage: UIImage!


  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    showNavBarSeparator(false)
    setupKeyboardNotifications()
    amountTextField.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    showNavBarSeparator(true)
  }
  
  // MARK: Privates
  
  private func setupKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardWillShow(notification: Notification) {
    let userInfo = notification.userInfo!
    let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
    keyboardConstraint.constant = keyboardFrame.size.height + 10
    view.layoutIfNeeded()
  }
  
  @objc func keyboardWillHide(notification: Notification){
    keyboardConstraint.constant = 10
    view.layoutIfNeeded()
  }
  
  // MARK: Actions
  
  @IBAction func sendPressed(_ sender: UIButton) {
    output.didSendPressed()
  }
  
  @IBAction func scanQRPressed(_ sender: UIButton) {
    output.didScanPressed()
  }
  
  @IBAction func addressDidChange(_ sender: UITextField) {
    output.didChangeAddress(sender.text!)
  }
  
  @IBAction func amountDidChange(_ sender: UITextField) {
    output.didChangeAmount(sender.text!)
  }
  
  @IBAction func gasLimitDidChange(_ sender: UITextField) {
    output.didChangeGasLimit(sender.text!)
  }

}


// MARK: - SendTokenViewInput

extension SendTokenViewController: SendTokenViewInput {

  func setupInitialState() {
    inputDataIsValid(false)
  }
  
  func didReceiveToken(_ token: Token) {
    let title = Localized.sendTitle(token.balance.name)
    navigationItem.title = title
  }
  
  func didDetectQRCode(_ code: String) {
    addressTextField.text = code
  }
  
  func didReceiveCheckout(ethFee: String, fiatFee: String) {
    feeLabel.text = ethFee
    localFeeLabel.text = Localized.sendFee(fiatFee)
  }
  
  func inputDataIsValid(_ isValid: Bool) {
    sendButton.alpha = isValid ? 1.0 : 0.5
    sendButton.isEnabled = isValid
  }
  
  func didReceiveGasLimit(_ gasLimit: Decimal) {
    gasLimitTextField.text = "\(gasLimit)"
  }
  
  func didReceiveGasPrice(_ gasPrice: Decimal) {
    let gwei = gasPrice.weiToGwei()
    gasPriceLabel.text = Localized.sendGasPrice("\(gwei)")
  }
  
  func showLoading() {
    view.endEditing(true)
    Loading.show()
  }
  
  func loadingSuccess() {
    Loading.success()
  }
  
  func loadingFilure() {
    Loading.dismiss()
    amountTextField?.becomeFirstResponder()
  }

}
