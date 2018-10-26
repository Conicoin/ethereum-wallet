// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import XCTest

class TxMetaResolverTests: XCTestCase {
  
  let normalInputString = "0x"
  let erc20InputString = "0xa9059cbb000000000000000000000000c1eb62f54b426d6050eb26fdef2f5f49551762800000000000000000000000000000000000000000000000000000000000000002"

  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testTxMetaResolver() {
    do {
      let resolver = TxMetaChain()
      
      let normalInput = try Data(hexString: normalInputString)
      let normalType = resolver.resolve(input: normalInput)
      XCTAssertEqual(normalType, .normal, "NormalTx not resolved")
      
      let erc20Input = try Data(hexString: erc20InputString.deleting0x())
      let erc20Type = resolver.resolve(input: erc20Input)
      XCTAssertEqual(erc20Type, .erc20(to: "0xc1eb62f54b426d6050eb26fdef2f5f4955176280", value: "2"), "Erc20 not resolved")
    } catch {
      XCTFail(error.localizedDescription)
    }
  }

}
