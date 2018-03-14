//
//  PasscodePostProcessProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

protocol PasscodePostProcessProtocol {
  func perform(with passphrase: String) throws
}
