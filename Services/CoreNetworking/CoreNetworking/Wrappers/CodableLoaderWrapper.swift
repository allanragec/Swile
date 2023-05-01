//
//  CodableLoaderWrapper.swift
//  CoreNetworking
//
//  Created by Allan Melo on 30/04/23.
//

import CoreNetworkingAPI

public class CodableLoaderWrapper: CodableLoaderProtocol {
    enum HandledError: Error {
        case couldNotCreateURL(endpoint: String)
    }
    
    public init() {}
    
    public func getAsync<Model: Decodable>(_ input: RequestInput) async throws -> Model {
        return try await CodableLoader<Model>(
            url: try makeURL(input.endpoint),
            urlSession: input.urlSession
        ).getAsync()
    }
    
    public func get<Model: Decodable>(
        _ input: RequestInput,
        completion: @escaping (Result<Model, Error>) -> Void
    ) {
        do {
            let url = try makeURL(input.endpoint)
            CodableLoader<Model>(
                url: url,
                urlSession: input.urlSession
            )
            .get() { result in
                completion(result)
            }
        }
        catch {
            completion(.failure(HandledError.couldNotCreateURL(endpoint: input.endpoint)))
        }
    }
    
    private func makeURL(_ endpoint: String) throws -> URL {
        guard let url = URL(string: endpoint) else {
            throw HandledError.couldNotCreateURL(endpoint: endpoint)
        }
        
        return url
    }
}
