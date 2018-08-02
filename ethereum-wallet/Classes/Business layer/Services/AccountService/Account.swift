//
//  Account.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 02/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

enum AccountType: Int, Codable {
  case mnemonic
  case privateKey
}

struct Account: Codable {
  let type: AccountType
  let key: String
}


