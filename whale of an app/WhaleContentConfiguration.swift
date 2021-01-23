//
//  WhaleContentConfiguration.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/22/21.
//

import UIKit

struct WhaleContentConfiguration: UIContentConfiguration, Hashable {
  var name: String?
  var image: UIImage?
  var backgroundColor: UIColor?
  var tintColor: UIColor?
  
  
  func makeContentView() -> UIView & UIContentView {
    WhaleVerticalContentView(configuration: self)
  }
  
  func updated(for state: UIConfigurationState) -> WhaleContentConfiguration {
    guard let state = state as? UICellConfigurationState else {
      return self
    }
    
    var updatedConfiguration = self
    if state.isSelected {
      updatedConfiguration.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
    } else {
      updatedConfiguration.tintColor = UIColor.clear
    }
    
    return updatedConfiguration
  }
}
