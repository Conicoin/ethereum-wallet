//  MIT License
//
//  Copyright (c) 2017 Artur Guseinov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import Alamofire


enum API {}


protocol APIMethodProtocol: URLRequestConvertible {
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var params: Params? { get }
    
    // Optional
    var headers: [String: String] { get }
}


extension APIMethodProtocol {
    
    typealias Params = [String: Any?]
    
    var baseUrl: String {
        return "https://rinkeby.etherscan.io/api?"
    }
    
    var requestTimeout: TimeInterval {
        return 20
    }
    
    var path: String {
        return ""
    }
    
    var params: Params? {
        return nil
    }
    
    var headers: [String: String] {
        return [String: String]()
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try (baseUrl + path).asURL()
        
        var urlRequest = Alamofire.URLRequest(url: url)
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        urlRequest.timeoutInterval = requestTimeout
        urlRequest.httpMethod = method.rawValue
        
        for header in headers {
            urlRequest.setValue(header.1, forHTTPHeaderField: header.0)
        }
        
        
        switch method {
        case .get:
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: params?.safe())
        case .post:
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: params?.safe())
        default:
            return urlRequest
        }
    }
    
}

// MARK: - Removing all key-value pairs with nil value

extension Dictionary where Key == String, Value == Any? {
    
    func safe() -> [String: Any] {
        var dict = [String: Any]()
        for (key, value) in self {
            if let value = value {
                dict[key] = value
            }
        }
        return dict
    }
    
}

