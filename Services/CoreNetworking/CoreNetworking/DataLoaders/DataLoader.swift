//
//  DataLoader.swift
//  CoreNetworking
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation
import Combine
import CoreNetworkingAPI

public class DataLoader: NSObject {
    public enum DataLoaderError: Error {
        case genericError
    }
    
    let urlSession: URLSession
    let url: URL
    let headers: [String: String]

    public init(
        url: URL,
        urlSession: URLSession = .shared,
        headers: [String: String] = [:]
    ) {
        self.url = url
        self.headers = headers
        self.urlSession = urlSession
    }
    
    public func post(
        formData: [String: String],
        contentType: String = "application/x-www-form-urlencoded",
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        let body = formData.map { "\($0)=\($1)" }
            .joined(separator: "&")
        
        let data = body.data(using: .utf8)
        let urlRequest = createRequest(
            method: "POST",
            body: data,
            contentType: contentType
        )
        
        executeDataTask(urlRequest, completion: completion)
    }
    
    public func createRequest(
        _ data: Data? = nil,
        httpMethod: String = RequestInput.Method.get.rawValue,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        let urlRequest = createRequest(
            method: httpMethod,
            body: data
        )
        
        executeDataTask(urlRequest, completion: completion)
    }
    
    public func createAsyncRequest(
        _ data: Data? = nil,
        httpMethod: String = RequestInput.Method.get.rawValue
    ) async throws -> (Data, URLResponse) {
        let urlRequest = createRequest(
            method: httpMethod,
            body: data
        )
        
        return try await executeTaskAsync(urlRequest)
    }
    
    private func executeDataTask(
        _ request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    completion(.success(data))
                }
                else {
                    completion(.failure(error ?? DataLoaderError.genericError ))
                }
            }
        }.resume()
    }
    
    private func executeTaskAsync(
        _ request: URLRequest
    ) async throws -> (Data, URLResponse) {
        return try await urlSession.data(for: request)
    }
    
    private func createRequest(
        method: String = RequestInput.Method.get.rawValue,
        body: Data? = nil,
        contentType: String = "application/json"
    ) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body
        var headers = headers
        headers["Content-Type"] = contentType
        
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
}
