//
//  Networking.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol NetworkOperationProtocol {
    associatedtype ResponseSerializer: DataResponseSerializerProtocol
    typealias ResponseObject = ResponseSerializer.SerializedObject
    
    var request: URLRequestConvertible { get }
    var responseSerializer: ResponseSerializer { get }
    var completion: ((Result<ResponseObject>) -> Void)? { get }
}

class Networking: NSObject {
    
    static let shared = Networking()
    
    struct AnyOperation<ResponseSerializer: DataResponseSerializerProtocol>: NetworkOperationProtocol {
        
        var request: URLRequestConvertible
        var responseSerializer: ResponseSerializer
        var completion: ((Result<ResponseSerializer.SerializedObject>) -> Void)?
        
        func execute() {
            Alamofire.request(request).response(queue: DispatchQueue.main, responseSerializer: responseSerializer) { response in
                NSLog(response.request!.url!.absoluteString)
                NSLog(String(data: response.data!, encoding: String.Encoding.utf8)!)
                self.completion?(response.result)
            }
        }
    }
    
}

extension Networking {
    
    // MARK: - Response Object
    
    typealias ResultObjectBlock<T: ImmutableMappable> = (Result<T>) -> Void
    
    func loadObject<T>(request: URLRequestConvertible, keyPath: String? = nil, completion: @escaping ResultObjectBlock<T>) where T: ImmutableMappable {
        let operation = AnyOperation(request: request,
                                     responseSerializer: DataRequest.ObjectMapperImmutableSerializer(keyPath, context: nil),
                                     completion: completion)
        operation.execute()
    }
    
    // MARK: - Response JSON
    
    typealias ResultJSONBlock = (Result<Any>) -> Void
    
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
    
    typealias ResultArrayBlock<T: ImmutableMappable> = (Result<[T]>) -> Void
    
    func loadArray<T>(request: URLRequestConvertible, keyPath: String? = nil, completion: @escaping ResultArrayBlock<T>) where T: ImmutableMappable {
        let operation = AnyOperation(request: request,
                                     responseSerializer: DataRequest.ObjectMapperImmutableArraySerializer(keyPath, context: nil),
                                     completion: completion)
        operation.execute()
    }
}
