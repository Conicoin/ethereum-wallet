// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

protocol QRServiceProtocol {
  func createQR(fromString string: String, size: CGSize) throws -> UIImage
}
