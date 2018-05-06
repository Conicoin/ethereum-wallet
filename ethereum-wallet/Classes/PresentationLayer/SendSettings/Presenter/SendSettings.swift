//
//  SendSettings.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 04/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct SendSettings {
  var gasPrice: Decimal
  var gasLimit: Decimal
  var txData: Data?
}
