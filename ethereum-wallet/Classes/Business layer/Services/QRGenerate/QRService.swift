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

enum QRServiceError: Error {
  case cantCreateQR
}

class QRService: QRServiceProtocol {
  
  func createQR(fromString string: String, size: CGSize) throws -> UIImage {
    guard
      let data = string.data(using: String.Encoding.utf8),
      let filter = CIFilter(name: "CIQRCodeGenerator"),
      let colorFilter = CIFilter(name: "CIFalseColor") else {
        throw QRServiceError.cantCreateQR
    }
    
    filter.setValue(data, forKey: "inputMessage")
    filter.setValue("L", forKey: "inputCorrectionLevel")
    
    colorFilter.setValue(filter.outputImage, forKey: "inputImage")
    
    guard let qrCodeImage = colorFilter.outputImage else {
      throw QRServiceError.cantCreateQR
    }
    
    let scaleX = size.width / qrCodeImage.extent.size.width
    let scaleY = size.height / qrCodeImage.extent.size.height
    let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    
    guard let output = filter.outputImage?.transformed(by: transform) else {
      throw QRServiceError.cantCreateQR
    }
    
    return UIImage(ciImage: output)
  }
  
}
