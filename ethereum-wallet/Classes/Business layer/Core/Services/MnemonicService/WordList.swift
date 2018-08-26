//
//  WordList.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 02/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

enum WordList {
  case english
  case japanese
  
  public var words: [String] {
    switch self {
    case .english:
      return englishWords
    case .japanese:
      return japaneseWords
    }
  }
}

