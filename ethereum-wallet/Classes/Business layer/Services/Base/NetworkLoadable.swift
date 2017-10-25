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

import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol NetworkLoadable {
  typealias ResultObjectBlock<T> = (Result<T>) -> Void
  typealias ResultJSONBlock = (Result<Any>) -> Void
  typealias ResultArrayBlock<T> = (Result<[T]>) -> Void
  
  func loadObject<PlainType: ImmutableMappable>(request: URLRequestConvertible, keyPath: String?, completion: @escaping ResultObjectBlock<PlainType>)
  func loadObjectJSON(request: URLRequestConvertible, completion: @escaping ResultJSONBlock)
  func loadArrayJSON(request: URLRequestConvertible, completion: @escaping ResultJSONBlock)
  func loadArray<PlainType: ImmutableMappable>(request: URLRequestConvertible, keyPath: String?, completion: @escaping ResultArrayBlock<PlainType>)
}

extension NetworkLoadable {
  
  // MARK: - Response Object
  
  func loadObject<PlainType: ImmutableMappable>(request: URLRequestConvertible, keyPath: String? = nil, completion: @escaping ResultObjectBlock<PlainType>) {
    let operation = AnyOperation(request: request,
                                 responseSerializer: DataRequest.ObjectMapperImmutableSerializer(keyPath, context: nil),
                                 completion: completion)
    operation.execute()
  }
  
  // MARK: - Response JSON
  
  func loadObjectJSON(request: URLRequestConvertible, completion: @escaping ResultJSONBlock) {
    let operation = AnyOperation(request: request,
                                 responseSerializer: DataRequest.jsonResponseSerializer(options: .allowFragments),
                                 completion: completion)
    operation.execute()
  }
  
  func loadArrayJSON(request: URLRequestConvertible, completion: @escaping ResultJSONBlock) {
    let operation = AnyOperation(request: request,
                                 responseSerializer: DataRequest.jsonResponseSerializer(options: .allowFragments),
                                 completion: completion)
    operation.execute()
  }
  
  // MARK: - Response Array
  
  func loadArray<PlainType: ImmutableMappable>(request: URLRequestConvertible, keyPath: String? = nil, completion: @escaping ResultArrayBlock<PlainType>) {
    let operation = AnyOperation(request: request,
                                 responseSerializer: DataRequest.ObjectMapperImmutableArraySerializer(keyPath, context: nil),
                                 completion: completion)
    operation.execute()
  }
}

fileprivate protocol NetworkOperationProtocol {
  associatedtype ResponseSerializer: DataResponseSerializerProtocol
  typealias ResponseObject = ResponseSerializer.SerializedObject
  
  var request: URLRequestConvertible { get }
  var responseSerializer: ResponseSerializer { get }
  var completion: ((Result<ResponseObject>) -> Void)? { get }
}

fileprivate struct AnyOperation<ResponseSerializer: DataResponseSerializerProtocol>: NetworkOperationProtocol {
  
  var request: URLRequestConvertible
  var responseSerializer: ResponseSerializer
  var completion: ((Result<ResponseSerializer.SerializedObject>) -> Void)?
  
  func execute() {
    Alamofire.request(request).response(queue: DispatchQueue.main, responseSerializer: responseSerializer) { response in
      self.completion?(response.result)
    }
  }
}
