//
//  Logger.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation

class Logger {
  
  enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
    case fatal = "FATAL"
  }
  
  static let defaultLevel: LogLevel = .warning
  static var dateFormat = "yyyy-MM-dd HH:mm:ss"
  static var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    formatter.locale = Locale.current
    formatter.timeZone = TimeZone.current
    return formatter
  }
  
  private class func sourceFileName(filePath: String) -> String {
    let components = filePath.components(separatedBy: "/")
    return components.isEmpty ? "" : components.last!
  }
  
  class func log(_ message: String,
                 level: LogLevel = defaultLevel,
                 fileName: String = #file,
                 line: Int = #line,
                 funcName: String = #function) {
    let logString = "\(Date().toString()) [\(level.rawValue)] [\(sourceFileName(filePath: fileName)):\(line)] \(funcName) -> \(message)"
    print(logString)
  }
  
  class func debug(_ text: String,
                   fileName: String = #file,
                   line: Int = #line,
                   funcName: String = #function) {
    log(text, level: .debug, fileName: fileName, line: line, funcName: funcName)
  }
  
  class func info(_ text: String,
                  fileName: String = #file,
                  line: Int = #line,
                  funcName: String = #function) {
    log(text, level: .info, fileName: fileName, line: line, funcName: funcName)
  }
  
  class func warn(_ text: String,
                  fileName: String = #file,
                  line: Int = #line,
                  funcName: String = #function) {
    log(text, level: .warning, fileName: fileName, line: line, funcName: funcName)
  }
  
  class func error(_ text: String,
                   fileName: String = #file,
                   line: Int = #line,
                   funcName: String = #function) {
    log(text, level: .error, fileName: fileName, line: line, funcName: funcName)
  }
  
  class func fatal(_ text: String,
                   fileName: String = #file,
                   line: Int = #line,
                   funcName: String = #function) {
    log(text, level: .fatal, fileName: fileName, line: line, funcName: funcName)
  }
}

fileprivate extension Date {
  func toString() -> String {
    return Logger.dateFormatter.string(from: self as Date)
  }
}
