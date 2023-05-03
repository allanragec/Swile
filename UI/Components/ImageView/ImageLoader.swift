//
//  DataLoader.swift
//  Components
//
//  Created by Allan Melo on 01/05/23.
//

import Combine
import UIKit

public struct ImageLoader {
    var urlSession = URLSession.shared
    private var urlString: String
    
    public init(urlString: String?) {
        self.urlString = urlString ?? ""
    }
    
    private let cache = ImageCache.shared
    
    public func load() -> AnyPublisher<UIImage?, Never> {
        guard let url = URL(string: self.urlString) else {
            print("ImageLoader: malformed URL")
            return Just(nil)
                .eraseToAnyPublisher()
        }
        
        if let image = cache[url.absoluteString] {
            return Just(image)
                .eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch {
                error -> AnyPublisher<UIImage?, Never> in
                print("error to get image \(error) | url : \(url)")
                return Just(nil)
                    .eraseToAnyPublisher()
            }
            .handleEvents(receiveOutput: { image in
                guard let image = image else { return }
                self.cache[url.absoluteString] = image
            })
            .subscribe(on: DispatchQueue.global())
            .eraseToAnyPublisher()
    }
}
