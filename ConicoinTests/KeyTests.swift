// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import XCTest

class KeyTests: XCTestCase {
  
  let _jsonKey = "{\"version\":3,\"id\":\"94cc0648-7992-4ed6-bfaf-97c215b44f15\",\"address\":\"9942b0270a5972c0969d74ddc438d36798d505e9\",\"Crypto\":{\"ciphertext\":\"38dc240ca95425f29249bfc28e9c8ad971b540769a5664a1196ea637ad69020c\",\"cipherparams\":{\"iv\":\"f2891cf176ff03d1925574bf8fc2b913\"},\"cipher\":\"aes-128-ctr\",\"kdf\":\"scrypt\",\"kdfparams\":{\"dklen\":32,\"salt\":\"09d107a18842462255a8c280e011a0fd99703d91a3b70b4597bbccfb09216745\",\"n\":8192,\"r\":8,\"p\":1},\"mac\":\"1c3220133476279b3a2834ef4f147c38307d0d9d6b11ce52303abcdf4101a8e9\"}}"
  let _privateKey = "14528e8f4f789495a2ea75ec7dbefef0f4816b174a2de772bf287fe1d9c707b6"
  let _password = "123123123"
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testKeyFromPrivate() {
    let data = try! Data(hexString: _privateKey)
    do {
      let key = try Key(privateKey: data, password: _password)
      let jsonData = try JSONEncoder().encode(key)
      let jsonKey = String(data: jsonData, encoding: .utf8)!
      
      guard let data = jsonKey.data(using: .utf8) else {
        XCTFail("Bad json key")
        return
      }
      
      let restored = try JSONDecoder().decode(Key.self, from: data)
      XCTAssertEqual(key.address, restored.address)
      
    } catch {
      XCTFail(error.localizedDescription)
    }
  }

  
}
