// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class ImportViewController: UIViewController {
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var inputTextView: DefaultTextField!
  @IBOutlet var icloudButton: UIButton!
  @IBOutlet var confirmButton: UIButton!
  @IBOutlet var bottomConstraint: NSLayoutConstraint!
  
  var output: ImportViewOutput!

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    inputTextView.textField.delegate = self
    setupKeyboardNotifications()
    localize()
    output.viewIsReady()
  }
  
  // MARK: Privates
  
  private func localize() {
    titleLabel.text = Localized.importTitle()
    icloudButton.setTitle(Localized.importIcloudTitle(), for: .normal)
    confirmButton.setTitle(Localized.importConfirmTitle(), for: .normal)
  }
  
  private func setupKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: Notification){
    let userInfo = notification.userInfo!
    let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    bottomConstraint.constant = keyboardFrame.size.height + 16
    view.layoutIfNeeded()
  }
  
  @objc func keyboardWillHide(notification: Notification){
    bottomConstraint.constant = 16
    view.layoutIfNeeded()
  }

  // MARK: Action
  
  @IBAction func icloudPressed(_ sender: UIButton) {
    let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text"], in: .import)
    documentPicker.delegate = self
    present(documentPicker, animated: true, completion: nil)
  }
  
  @IBAction func confirmPressed(_ sender: UIButton) {
    output.didConfirmKey(inputTextView.textField.text!)
  }
  
}


// MARK: - ImportViewInput

extension ImportViewController: ImportViewInput {
    
  func setupInitialState() {

  }
  
  func setState(_ state: ImportStateProtocol) {
    inputTextView.placeholder = state.placeholder
    icloudButton.isHidden = !state.iCloudImportEnabled
  }

}


// MARK: - UITextFieldDelegate

extension ImportViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    confirmButton.isEnabled = !text.isEmpty
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    confirmPressed(confirmButton)
    return true
  }
  
}


// MARK: UIDocumentPickerDelegate

extension ImportViewController: UIDocumentPickerDelegate {
  
  func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    if let url = urls.first, let text = try? String(contentsOfFile: url.path) {
      output.didConfirmKey(text)
    }
  }
  
}
