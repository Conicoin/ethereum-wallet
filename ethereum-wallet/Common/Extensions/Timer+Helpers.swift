// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

extension Timer {
  
  class func createDispatchTimer(interval: DispatchTimeInterval,
                                 leeway: DispatchTimeInterval,
                                 queue: DispatchQueue,
                                 block: @escaping ()->()) -> DispatchSourceTimer {
    let timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: 0),
                                               queue: queue)
    timer.schedule(deadline: DispatchTime.now(),
                   repeating: interval,
                            leeway: leeway)
    
    // Use DispatchWorkItem for compatibility with iOS 9. Since iOS 10 you can use DispatchSourceHandler
    let workItem = DispatchWorkItem(block: block)
    timer.setEventHandler(handler: workItem)
    timer.resume()
    return timer
  }
}
