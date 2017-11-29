// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


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
