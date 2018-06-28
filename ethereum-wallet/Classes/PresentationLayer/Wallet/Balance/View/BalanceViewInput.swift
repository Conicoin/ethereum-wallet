// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import UIKit


protocol BalanceViewInput: class, Presentable {
  func setupInitialState()
  func endRefreshing()
  func setTotalTokenAmount(_ currency: String)
  func setPreviewTitle(_ currency: String, coin: Coin)
  func setCoin(_ coin: Coin)
  func setTokens(_ tokens: [Token])
  func setTokens(_ tokens: [Token], deleteons: [Int], insertions: [Int], modifications: [Int])
}
