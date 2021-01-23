//
//  Repository.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/23/21.
//

import Foundation

class Repository {
  private static var cache = [URL:Data]()
  
  static func loadImageData(with imageUrl: URL, completion: @escaping (Data?) -> Swift.Void) {
    if let cachedImageData = cache[imageUrl] {
      DispatchQueue.main.async {
            completion(cachedImageData)
        }
        return
    }
    else {
      let task = URLSession.shared.downloadTask(with: imageUrl) {
        location, response, error in
        guard let location = location, let imageData = try? Data(contentsOf: location) else { return }
        
        cache[imageUrl] = imageData
        
        DispatchQueue.main.async {
          completion(imageData)
        }
      }
      task.resume()
    }
  }
}
