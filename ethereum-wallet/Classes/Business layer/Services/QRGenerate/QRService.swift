// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
    
    let context = CIContext(options: nil)
    guard let cgImage = context.createCGImage(output, from: output.extent) else {
      throw QRServiceError.cantCreateQR
    }
    return UIImage(cgImage: cgImage)
  }
  
}
