//
//  Channel.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class Channel<SignalData> {
  private var observers: Set<Observer<SignalData>>
  
  init() {
    observers = Set<Observer<SignalData>>()
  }
  
  func addObserver(_ observer: Observer<SignalData>) {
    if observers.contains(observer) {
      observers.remove(observer)
      observers.insert(observer)
    } else {
      observers.insert(observer)
    }
  }
  
  func removeObserver(withId observerId: Identifier) {
    if let observer = observers.first(where: { $0.id == observerId }) {
      removeObserver(observer)
    }
  }
  
  func removeObserver(_ observer: Observer<SignalData>) {
    _ = observers.remove(observer)
  }
  
  func send(_ value: SignalData) {
    for observer in observers {
      observer.send(value)
    }
  }
}

extension Channel {
  func removeObserver(withId observerId: String) {
    self.removeObserver(withId: Identifier(observerId))
  }
}
