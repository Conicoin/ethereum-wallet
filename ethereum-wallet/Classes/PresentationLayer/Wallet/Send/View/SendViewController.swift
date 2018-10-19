// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class SendViewController: UIViewController {
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var sendButton: UIButton!
  @IBOutlet var balanceLabel: UILabel!
  @IBOutlet var currencyLabel: UILabel!
  @IBOutlet var amountTextField: UITextField!
  @IBOutlet var currencyButton: UIButton!
  @IBOutlet var localAmountLabel: UILabel!
  @IBOutlet var recepientTextField: DefaultTextField!
  @IBOutlet var scanQrButton: UIButton!
  @IBOutlet var feeTitleLabel: UILabel!
  @IBOutlet var totalTitleLabel: UILabel!
  @IBOutlet var feeLabel: UILabel!
  @IBOutlet var totalLabel: UILabel!
  @IBOutlet var keyboardConstraint: NSLayoutConstraint!
  
  
  var output: SendViewOutput!
  var amountFormatter: AmountFormatterProtocol!
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    localize()
    setupTextFields()
    scrollView.setupBorder()
    recepientTextField.textField.addTarget(self, action: #selector(addressChanged(_:)), for: .editingChanged)
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    amountTextField.becomeFirstResponder()
  }
  
  // MARK: Privates
    
  private func localize() {
    recepientTextField.placeholder = Localized.sendAddressPlaceholder()
    sendButton.setTitle(Localized.sendTitleEmpty(), for: .normal)
  }
  
  private func setupTextFields() {
    amountTextField.keyboardType = amountFormatter.allowFraction ? .decimalPad : .numberPad
    recepientTextField.textField.setRightPadding(30)
  }
  
  // MARK: Actions
  
  @IBAction func sendPressed(_ sender: UIButton) {
    output.didSendPressed()
  }
  
  @IBAction func currencyPressed(_ sender: UIButton) {
    output.didCurrencyPressed()
  }
  
  @IBAction func scanQRPressed(_ sender: UIButton) {
    output.didScanPressed()
  }
  
  @IBAction func amountDidChange(_ sender: UITextField) {
    output.didChangeAmount(sender.text!)
  }
  
  @IBAction func advancedPressed(_ sender: UIBarButtonItem) {
    output.didAdvancedPressed()
  }
  
  @objc func addressChanged(_ sender: UITextField) {
    output.didChangeAddress(sender.text!)
  }
  
}

// MARK: - SendViewInput

extension SendViewController: SendViewInput {
  
  func setupInitialState() {
    inputDataIsValid(false)
  }
  
  func setCoin(_ coin: AbstractCoin) {
    let title = Localized.sendTitle(coin.currency.name)
    navigationItem.title = title
    balanceLabel.text = coin.currency.amountString
    currencyLabel.text = coin.currency.symbol
  }
  
  func setAddressFromQR(_ address: String) {
    recepientTextField.textField.text = address
    recepientTextField.changeToFloat(animated: true)
  }
  
  func setLocalAmount(_ localAmount: String?) {
    localAmountLabel.text = localAmount
  }
  
  func setCheckout(amount: String, total: String, fee: String) {
    feeTitleLabel.text = Localized.sendFee()
    totalTitleLabel.text = Localized.sendTotal()
    totalLabel.text = total
    feeLabel.text = fee
    UIView.performWithoutAnimation {
      self.sendButton.setTitle(Localized.sendTitle(amount), for: .normal)
      self.sendButton.layoutIfNeeded()
    }
  }
  
  func setCurrency(_ currency: String) {
    UIView.performWithoutAnimation {
      self.currencyButton.setTitle(currency, for: .normal)
      self.currencyButton.layoutIfNeeded()
    }
  }
  
  func inputDataIsValid(_ isValid: Bool) {
    sendButton.isEnabled = isValid
  }

  func loadingFilure() {
    amountTextField?.becomeFirstResponder()
  }

}

// MARK: - UITextFieldDelegate

extension SendViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
    return amountFormatter.isValidDecimal(input: replacementText)
  }
  
}
