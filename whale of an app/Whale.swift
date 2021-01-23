//
//  WhaleDataModel.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/21/21.
//

import Foundation

struct Whale: Identifiable, Hashable {
  let id = UUID()
  var name: String
  var imageData: Data? = nil
  var imageUrl: String
  
  func hash(into hasher: inout Hasher) {
      hasher.combine(id)
  }
  
  mutating func setImageData(data: Data?) {
    imageData = data
  }
}
