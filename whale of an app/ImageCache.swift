//
//  ImageCache.swift
//  whale of an app
//
//  Created by Bijan Fazeli on 1/23/21.
//

import Foundation

import UIKit
public class ImageRepository {
    public static let publicCache = ImageRepository()
    var placeholderImage = UIImage(systemName: "rectangle")!
    private let cachedImages = NSCache<NSURL, UIImage>()
  private var loadingResponses = [NSURL: [(UIImage?) -> Swift.Void]]()
    
    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    /// - Tag: cache
    // Returns the cached image if available, otherwise asynchronously loads and caches it.
    final func load(url: NSURL, completion: @escaping (UIImage?) -> Swift.Void) {
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        // In case there are more than one requestor for the image, we append their completion block.
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        // Go fetch the image.
        ImageService.urlSession().dataTask(with: url as URL) { (data, response, error) in
            // Check for the error, then data and try to create the image.
            guard let responseData = data, let image = UIImage(data: responseData),
                let blocks = self.loadingResponses[url], error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            // Cache the image.
            self.cachedImages.setObject(image, forKey: url, cost: responseData.count)
            // Iterate over each requestor for the image and pass it back.
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
                return
            }
        }.resume()
    }
        
}
