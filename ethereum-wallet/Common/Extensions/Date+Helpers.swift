// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

extension Date {
  
  func dayDifference() -> String {
    let calendar = NSCalendar.current
    if calendar.isDateInYesterday(self) { return Localized.timeYestarday() }
    else if calendar.isDateInToday(self) { return Localized.timeToday() }
    else if calendar.isDateInTomorrow(self) { return Localized.timeTomorrow() }
    else {
      return humanReadable()
    }
  }
  
  func humanReadable() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter.string(from: self)
  }
  
  func detailed() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: self)
  }

}
