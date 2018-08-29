// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

enum SyncMode: Int {
  case standard
  case secure
  
  var isSecureMode: Bool {
    return Bool(rawValue)
  }
  
}
