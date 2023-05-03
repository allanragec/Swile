//
//  CodableLoader.swift
//  CoreNetworking
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation
import Combine
import CoreNetworkingAPI

public struct CodableLoader<Model: Decodable> {
    let dataLoader: DataLoader
    
    public init(
        url: URL,
        urlSession: URLSession = .shared,
        headers: [String: String] = [:]
    ) {
        self.dataLoader = DataLoader(
            url: url,
            urlSession: urlSession,
            headers: headers
        )
    }
    
    var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.defaultFormatter)
        return decoder
    }()
    
    var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    func post(
        formData: [String: String],
        completion: @escaping (Result<Model, Error>) -> Void
    ) {
        dataLoader
            .post(formData: formData, completion: { result in
                mapResult(result: result, completion: completion)
            })
    }
    
    public func get(
        completion: @escaping (Result<Model, Error>) -> Void
    ) {
        dataLoader
            .createRequest(
                httpMethod: RequestInput.Method.get.rawValue,
                completion: { result in
                    mapResult(result: result, completion: completion)
                })
    }
    
    public func getAsync() async throws -> Model {
        let task = Task { () -> Model in
            let (data, _) = try await dataLoader.createAsyncRequest(
                httpMethod: RequestInput.Method.get.rawValue
            )
            
            return try decoder.decode(Model.self, from: data)
            
        }

        return try await task.value
    }
    
    func createRequest<Payload: Encodable>(
        _ model: Payload,
        httpMethod: String = RequestInput.Method.post.rawValue,
        completion: @escaping (Result<Model, Error>) -> Void
    ) {
        do {
            let data = try encoder.encode(model)
            dataLoader
                .createRequest(
                    data,
                    httpMethod: httpMethod,
                    completion: { result in
                    mapResult(result: result, completion: completion)
                })
        }
        catch let error {
            completion(.failure(error))
        }
    }
    
    private func mapResult(
        result: Result<Data, Error>,
        completion: @escaping (Result<Model, Error>) -> Void
    ) {
        switch result {
        case let .success(data):
            do {
                let model = try decoder.decode(Model.self, from: data)
                completion(.success(model))
            }
            catch let error {
                completion(.failure(error))
            }
            
        case let .failure(error):
            completion(.failure(error))
        }
    }
}
