//
//  ImageCache.swift
//  Components
//
//  Created by Allan Melo on 02/05/23.
//

import Foundation
import UIKit.UIImage
import Combine

public protocol ImageCacheType: AnyObject {
    func image(for url: String) -> UIImage?
    func insertImage(_ image: UIImage?, for url: String)
    func removeImage(for url: String)
    func removeAllImages()
    subscript(_ url: String) -> UIImage? { get set }
}

public final class ImageCache: ImageCacheType {
    public static var shared: ImageCache = .init()
    
    private init() {
        self.config = Config.defaultConfig
    }

    private lazy var imageCache: NSCache<NSString, AnyObject> = {
        let cache = NSCache<NSString, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    private let lock = NSLock()
    private let config: Config

    public struct Config {
        public let countLimit: Int
        public let memoryLimit: Int

        public static let defaultConfig = Config(
            countLimit: 100,
            memoryLimit: 1024 * 1024 * 100 // 100 MB
        )
    }

    public func image(for url: String) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        if let image = imageCache.object(forKey: url as NSString) as? UIImage {
            return image
        }
        return nil
    }

    public func insertImage(_ image: UIImage?, for url: String) {
        guard let image = image else { return removeImage(for: url) }

        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(image, forKey: url as NSString, cost: 1)
    }

    public func removeImage(for url: String) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as NSString)
    }

    public func removeAllImages() {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
    }

    public subscript(_ key: String) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
}
