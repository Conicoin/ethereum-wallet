//
//  Timer+Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 15/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

extension Timer {
  
  @discardableResult
  class func schedule(delay: TimeInterval, handler: @escaping (Timer!) -> Void) -> Timer {
    let fireDate = delay + CFAbsoluteTimeGetCurrent()
    let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
    return timer!
  }
  
  @discardableResult
  class func schedule(repeatInterval interval: TimeInterval, handler: @escaping (Timer!) -> Void) -> Timer {
    let fireDate = interval + CFAbsoluteTimeGetCurrent()
    let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
    return timer!
  }
  
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
