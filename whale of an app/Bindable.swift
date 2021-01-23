//
//  Bindable.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/23/21.
//

import Foundation

class Bindable<T> {
  var value: T? {
    didSet {
      observer?(value)
    }
  }
  
  var observer: ((T?) -> ())?
  
  func bind(observer: @escaping (T?) -> ()) {
    self.observer = observer
  }
}
