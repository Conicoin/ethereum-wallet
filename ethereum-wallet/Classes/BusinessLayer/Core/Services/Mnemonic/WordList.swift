// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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

