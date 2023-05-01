//
//  CodableLoaderProtocol.swift
//  CoreNetworkingAPI
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

public protocol HasCodableLoader {
    var codableLoader: CodableLoaderProtocol { get }
}

public protocol CodableLoaderProtocol {
    func getAsync<Model: Decodable>(_ input: RequestInput) async throws -> Model
    func get<Model: Decodable>(_ input: RequestInput, completion: @escaping (Result<Model, Error>) -> Void)
}
