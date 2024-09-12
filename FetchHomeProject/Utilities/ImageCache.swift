//
//  ImageCache.swift
//  FetchHomeProject
//
//  Created by Yingzhe Hu on 9/11/24.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getImage(forKey key: String) async throws -> UIImage? {
        if let cachedImage = cache.object(forKey: key as NSString) { return cachedImage }
        guard let imageUrl = URL(string: key) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: imageUrl)
            if let loadedImage = UIImage(data: data) {
                self.cache.setObject(loadedImage, forKey: key as NSString)
                return loadedImage
            }
        } catch {
            throw NetworkError.fetchImageError
        }
        return nil
    }

//    func setImage(_ image: UIImage, forKey key: String) {
//        cache.setObject(image, forKey: key as NSString)
//    }
}
