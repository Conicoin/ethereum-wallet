// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

protocol PinRepositoryProtocol {
    
    var hasPin: Bool {get}
    var pin: [String]? {get}
    
    func savePin(_ pin: [String])
    func deletePin()
}
