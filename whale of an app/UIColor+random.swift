//
//  UIColor + random.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/23/21.
//

import UIKit

extension UIColor {
  static func random() -> UIColor {
    UIColor(
      red:   .random(in: 0...1),
      green: .random(in: 0...1),
      blue:  .random(in: 0...1),
      alpha: 0.2
    )
  }
}
