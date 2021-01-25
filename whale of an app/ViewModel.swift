//
//  MainViewModel.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/21/21.
//

import Foundation

class ViewModel {
  var bindableReloadCollectionView = Bindable<Bool>()
  
  private(set) lazy var listOfWhales: [Whale] =
    [
      Whale(name: "Bowhead", imageUrl: "https://media.fisheries.noaa.gov/styles/original/s3/dam-migration/640x427-bowhead-whale.png?null&itok=lVsJuc9v"),
      Whale(name: "Beluga", imageUrl: "https://media.fisheries.noaa.gov/styles/original/s3/dam-migration/640x427-beluga-whale.png?null&itok=KcnZO3rE"),
      Whale(name: "Killer", imageUrl: "https://media.fisheries.noaa.gov/styles/original/s3/dam-migration/640x427-killer-whale.png?null&itok=mpHhEa6Y"),
      Whale(name: "Humpback", imageUrl: "https://media.fisheries.noaa.gov/styles/original/s3/dam-migration/640x427-humpback.png?null&itok=xJdovo_r"),
      Whale(name: "False Killer", imageUrl: "https://media.fisheries.noaa.gov/styles/original/s3/dam-migration/640x427-killer-whale.png?null&itok=mpHhEa6Y"),
      Whale(name: "Gray", imageUrl: "https://media.fisheries.noaa.gov/styles/original/s3/dam-migration/640x427-gray-whale.png?null&itok=r5uMVbmg")
    ].shuffled()
  
  init() {
    loadData()
  }
  
  private func loadData() {
    for index in 0..<listOfWhales.count {
      guard let imageUrl = URL(string: listOfWhales[index].imageUrl) else { return }
      
      Repository.loadImageData(with: imageUrl) { (imageData) in
        self.listOfWhales[index].setImageData(data: imageData)
        self.bindableReloadCollectionView.value = true
      }
    }
  }
}
