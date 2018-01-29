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

extension String {
  
  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }
  
  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, count) ..< count]
  }
  
  func substring(toIndex: Int) -> String {
    return self[0 ..< max(0, toIndex)]
  }
  
  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                        upper: min(count, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }
  
  func renderImage(font: UIFont, size: CGSize, color: UIColor) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { ctx in
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      let attrs = [
        NSAttributedStringKey.font: font,
        NSAttributedStringKey.paragraphStyle: paragraphStyle,
        NSAttributedStringKey.foregroundColor: color
      ]
      let textSize = (self as NSString).size(withAttributes: attrs)
      let origin = CGPoint(x: 0, y: size.height/2 - textSize.height/2)
      let rect = CGRect(origin: origin, size: size)
      self.draw(with: rect, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
    }
  }
  
  func toHexData() -> Data? {
    var data = Data(capacity: count / 2)
    
    let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
    regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
      let byteString = (self as NSString).substring(with: match!.range)
      var num = UInt8(byteString, radix: 16)!
      data.append(&num, count: 1)
    }
    
    guard data.count > 0 else { return nil }
    
    return data
  }
  
}


