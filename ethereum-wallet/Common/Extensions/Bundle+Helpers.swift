// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

extension Bundle {
  
  var versionAndBuild: String {
    return "\(version) build \(build)"
  }
  
  var version: String {
    return infoDictionary!["CFBundleShortVersionString"] as! String
  }
  
  var build: String {
    return infoDictionary!["CFBundleVersion"] as! String
  }
  
  var displayName: String {
    return object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
  }
  
}
