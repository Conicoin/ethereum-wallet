// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

protocol WalletPrivateDisplayable {
  var address: String? { get set }
  var mnemonic: [String]? { get set }
  var name: String? { get set }
  var subtitle: String? { get set }
}
