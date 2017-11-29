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

extension Date {
  
  func dayDifference() -> String{
    let calendar = NSCalendar.current
    if calendar.isDateInYesterday(self) { return Localized.timeYestarday() }
    else if calendar.isDateInToday(self) { return Localized.timeToday() }
    else if calendar.isDateInTomorrow(self) { return Localized.timeTomorrow() }
    else {
      let startOfNow = calendar.startOfDay(for: Date())
      let startOfTimeStamp = calendar.startOfDay(for: self)
      let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
      let day = components.day!
      if day < 1 { return Localized.timeDaysAgo("\(abs(day))") }
      else { return Localized.timeInDays("\(day)") }
    }
  }

}
