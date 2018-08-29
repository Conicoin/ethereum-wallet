// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol TabBarInteractorOutput: class {
  func syncDidUpdateBalance(_ balance: Decimal)
  func syncDidFailedWithError(_ error: Error)
  func syncDidChangeProgress(current: Int64, total: Int64)
  func syncDidFinished()
}
