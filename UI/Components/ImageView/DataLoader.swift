//
//  DataLoader.swift
//  Components
//
//  Created by Allan Melo on 01/05/23.
//

import Combine

struct DataLoader {
    var urlSession = URLSession.shared
    var url: URL
    
    func load() -> AnyPublisher<Data, URLError> {
        urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
