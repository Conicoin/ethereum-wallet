//
//  WalletPrivateDisplayable.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 21/05/2018.
//  Copyright © 2018 Universa. All rights reserved.
//

import UIKit

protocol WalletPrivateDisplayable {
  var address: String? { get set }
  var mnemonic: [String]? { get set }
  var name: String? { get set }
  var subtitle: String? { get set }
}
