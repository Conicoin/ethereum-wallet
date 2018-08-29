// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import FirebaseCore

class ThirdPartiesConfigurator: ConfiguratorProtocol {

    func configure() {
      FirebaseApp.configure()
    }
    
}
