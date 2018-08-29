// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Rswift

class ScreenManager {
  
  static func instantiate<ViewController: UIViewController>(_ resource: StoryboardResourceType) -> ViewController {
    let device = UIDevice.screenType
    let storyboard = UIStoryboard(name: resource.name, bundle: nil)
    var viewController: UIViewController!
    do {
      try ObjC.catchException {
        let identifier = resource.name + "ViewController" + device.prefix
        viewController = storyboard.instantiateViewController(withIdentifier: identifier)
      }
    } catch {
      let identifier = resource.name + "ViewController"
      viewController = storyboard.instantiateViewController(withIdentifier: identifier)
    }
    return viewController as! ViewController
  }
  
}
