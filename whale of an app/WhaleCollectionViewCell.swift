//
//  WhaleCollectionViewCell.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/21/21.
//

import UIKit

class WhaleCollectionViewCell: UICollectionViewListCell {
  var whaleData: Whale? {
    didSet {
      backgroundConfiguration?.cornerRadius = 5
      backgroundConfiguration?.strokeColor = .systemGray3
      backgroundConfiguration?.strokeWidth = 1.0 / self.traitCollection.displayScale
      backgroundConfiguration?.backgroundColor = UIColor.random()
    }
  }
  
  override func updateConfiguration(using state: UICellConfigurationState) {
    var newContentConfiguration = WhaleContentConfiguration().updated(for: state)
    newContentConfiguration.name = whaleData?.name
    if let whaleImageData = whaleData?.imageData {
      newContentConfiguration.image = UIImage(data: whaleImageData)
    }
    
    contentConfiguration = newContentConfiguration
  }
}
