//
//  RequestInput.swift
//  CoreNetworkingAPI
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

public struct RequestInput {
    public let endpoint: String
    public let method: Method
    public let urlSession: URLSession
    public let headers: [String: String]
    public let payloadData: Data?
    
    public init(
        endpoint: String,
        method: Method = .get,
        urlSession: URLSession = .shared,
        headers: [String : String] = [:],
        payloadData: Data? = nil
    ) {
        self.endpoint = endpoint
        self.method = method
        self.urlSession = urlSession
        self.headers = headers
        self.payloadData = payloadData
    }
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}
