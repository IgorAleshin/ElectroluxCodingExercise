//
//  ImageCache.swift
//  ElectroluxCodingExercise
//
//  Created by Алешин Игорь Эдуардович on 21.07.2021.
//

import UIKit

final class ImageCache: ImageCacheProtocol {

    static var shared = ImageCache()

    private let cache: NSCache<NSString, UIImage> = .init()
    private let lock = NSRecursiveLock()

    func set(image: UIImage, for key: String) {
        let key = key as NSString
        lock.lock()
        cache.setObject(image, forKey: key)
        lock.unlock()
    }

    func getImage(for key: String) -> UIImage? {
        let key = key as NSString
        lock.lock()
        defer { lock.unlock() }
        return cache.object(forKey: key)
    }
}
