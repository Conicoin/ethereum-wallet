// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol TokenDetailsInteractorInput: class {
  func getTransactions(for token: Token)
}
