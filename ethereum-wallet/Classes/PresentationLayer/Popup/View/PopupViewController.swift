//
//  PopupPopupViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class PopupViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var skipButton: UIButton!
  @IBOutlet weak var confirmButton: UIButton!

  var output: PopupViewOutput!


  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.hidesBackButton = true
    output.viewIsReady()
  }
  
  // MARK: Actions
  
  @IBAction func confirmPressed(_ sender: UIButton) {
    output.didConfirmPressed()
  }
  
  @IBAction func skipPressed(_ sender: UIButton) {
    output.didSkipPressed()
  }

}


// MARK: - PopupViewInput

extension PopupViewController: PopupViewInput {
    
  func setupInitialState() {

  }
  
  func didReceiveState(_ state: PopupStateProtocol) {
    titleLabel.text = state.title
    descriptionLabel.text = state.description
    imageView.image = UIImage(named: state.imageName)
    skipButton.setTitle(state.skipTitle, for: .normal)
    confirmButton.setTitle(state.confirmTitle, for: .normal)
    skipButton.isHidden = !state.isSkipActive
  }

}
