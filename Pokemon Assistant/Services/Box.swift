//
//  Observer.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 1/17/22.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    //2
    var value: T {
      didSet {
        listener?(value)
      }
    }
    //3
    init(_ value: T) {
      self.value = value
    }
    //4
    func bind(listener: Listener?) {
      self.listener = listener
      listener?(value)
    }
}
