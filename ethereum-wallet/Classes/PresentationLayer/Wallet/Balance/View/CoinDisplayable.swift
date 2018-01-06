//
//  CoinDisplayable.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

protocol CoinDisplayable {
  var balance: Currency! { get }
  var rates: [Rate] { get }
  var color: UIColor { get }
  var iconUrl: URL? { get }
  func placeholder(with size: CGSize) -> UIImage
}

extension Coin: CoinDisplayable {
  
  var iconUrl: URL? {
    return nil
  }
  
  var color: UIColor {
    return Theme.Color.ethereum
  }
  
  func placeholder(with size: CGSize) -> UIImage {
    return R.image.ethereumIcon()!.withRenderingMode(.alwaysTemplate)
  }
  
}

extension Token: CoinDisplayable {
  
  var color: UIColor {
    return Theme.Color.token
  }
  
  func placeholder(with size: CGSize) -> UIImage {
    let font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    return balance.iso.renderImage(font: font, size: size, color: color)
  }
  
}
