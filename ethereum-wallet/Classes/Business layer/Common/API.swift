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
        return ""
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

