// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import FirebaseCore

class ThirdPartiesConfigurator: ConfiguratorProtocol {

    func configure() {
#if TESTNET
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-Testnet", ofType: "plist")!
#else
        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
#endif
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseApp.configure(options: options!)
    }
    
}
