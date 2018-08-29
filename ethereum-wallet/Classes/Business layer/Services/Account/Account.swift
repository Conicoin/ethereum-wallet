// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

enum AccountType: Int, Codable {
  case mnemonic
  case privateKey
}

struct Account: Codable {
  let type: AccountType
  let address: String
  let key: String
}


