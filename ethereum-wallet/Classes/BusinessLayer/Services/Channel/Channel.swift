// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

class Channel<SignalData> {
  private var observers: Set<Observer<SignalData>>
  private var queue: DispatchQueue
  
  init(queue: DispatchQueue) {
    self.queue = queue
    self.observers = Set<Observer<SignalData>>()
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
    for observer in self.observers {
      observer.send(value)
    }
  }
}

extension Channel {
  func removeObserver(withId observerId: String) {
    self.removeObserver(withId: Identifier(observerId))
  }
}
