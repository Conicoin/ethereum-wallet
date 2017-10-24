//
//  WelcomeWelcomeViewInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 19/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol WelcomeViewInput: class, Presentable {
  func setupInitialState(restoring: Bool)
}
