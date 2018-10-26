// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import XCTest
import CryptoSwift
@testable import ethereum_wallet

class ImportTests: XCTestCase {
  
  let _mnemonic = "analyst coach genuine letter diary point save share sound agent sister camera"
  let _address = "0xcc936EB4fC467f6B4D48da58FB05afCfbeCBCee2"
  let _privateKey = "474e4d87b48b1a47b21e3c68e579b8a6905ac2dd1f21e0732f2d49deeaa5a7c1"
  let _seed = "e10a31fa1a2ba8c59c1c36aeebe27028373b7dce3a096a150e22120c7e813c0f230d374122d2cf72b0181cbaca58be5e3b20dd0011ac948e765968a01c4c34ad"
  let _extMasterPrivKey = "xprv9s21ZrQH143K48LV9UHfbZuoWfhRGSkk2JWvEFA4aoVZ24MxfLfruX463n1fnkWAZKoBWUcUsgc4VbdmriDNkvSRGZmdco3YarvcvNqd34x"
  let _extMasterPubKey = "xpub661MyMwAqRbcGcQxFVpfxhrY4hXufuUbPXSX2dZg992Xtrh7Csz7TKNZu49fDXYf1XFJdd2462nDY3Jug9zxpCbYFVEdyoiMWyEiQD7otQG"
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testKeyFromPrivate() {
    let mnemonicService = MnemonicService()
    do {
      let mnemonic = _mnemonic.components(separatedBy: " ")
      let seed = try mnemonicService.createSeed(mnemonic: mnemonic, withPassphrase: "")
      
      XCTAssertEqual(seed.hex(), _seed)
      
      let chain = Chain.mainnet
      let masterPrivateKey = HDPrivateKey(seed: seed, network: chain)
      
      XCTAssertEqual(masterPrivateKey.extended(), _extMasterPrivKey)
      XCTAssertEqual(masterPrivateKey.hdPublicKey().extended(), _extMasterPubKey)
      
      let privateKey = try masterPrivateKey
        .derived(at: 44, hardens: true)
        .derived(at: chain.bip44CoinType, hardens: true)
        .derived(at: 0, hardens: true)
        .derived(at: 0)
        .derived(at: 0).privateKey()
      
      XCTAssertEqual(privateKey.raw.hex(), _privateKey)
                  
      let publicKey = privateKey.publicKey
      print(SHA3(variant: .keccak256).calculate(for: publicKey.raw.bytes).toHexString())
      print(CryptoHash.sha256(publicKey.raw).hex())
      XCTAssertEqual(try! publicKey.generateAddress().string, _address)
      XCTAssertEqual(privateKey.raw.hex(), _privateKey)
      
    } catch {
      XCTFail(error.localizedDescription)
    }
  }

}
