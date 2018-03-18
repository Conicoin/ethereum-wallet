//
//  Secp256k1.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import secp256k1_ios

class Secp256k1 {
    
    static let shared = Secp256k1()
    
    private let context: OpaquePointer
    
    init() {
        context = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN | SECP256K1_CONTEXT_VERIFY))!
    }

    func pubicKey(from privateKey: Data) -> Data {
        var pubKey = secp256k1_pubkey()
        var pubKeyData = Data(count: 65)
        _ = privateKey.withUnsafeBytes { key in
            secp256k1_ec_pubkey_create(context, &pubKey, key)
        }
        _ = pubKeyData.withUnsafeMutableBytes { (output: UnsafeMutablePointer<UInt8>) in
            var count = pubKeyData.count
            secp256k1_ec_pubkey_serialize(context, output, &count, &pubKey, UInt32(SECP256K1_EC_UNCOMPRESSED))
        }
        return pubKeyData
    }
    
}
