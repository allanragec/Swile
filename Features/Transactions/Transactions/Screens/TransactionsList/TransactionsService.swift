//
//  TransactionsService.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation
import TransactionsAPI
import Combine
import CoreNetworkingAPI

protocol TransactionsServicing {
    typealias TransactionListCompletion = (Result<TransansactionsResult, Error>) -> Void
    func getTransactions(completion: @escaping TransactionListCompletion)
    func getTransactionsAsync() async throws -> TransansactionsResult
}

class TransactionsService: TransactionsServicing {
    typealias Dependencies = HasCodableLoader
    
    let dependencies: Dependencies
    let requestInput = RequestInput(endpoint: Endpoints.getTransactions.rawValue)
    
    public init(
        dependenciesContainer: Dependencies = DependencyContainer()
    ) {
        self.dependencies = dependenciesContainer
    }
    
    func getTransactions(completion: @escaping (Result<TransansactionsResult, Error>) -> Void) {
        dependencies
            .codableLoader
            .get(requestInput) { result in
                completion(result)
            }
    }
    
    func getTransactionsAsync() async throws -> TransansactionsResult {
        try await dependencies
            .codableLoader
            .getAsync(RequestInput(
                endpoint: Endpoints.getTransactions.rawValue,
                urlSession: .init(configuration: .ephemeral)
            ))
    }
}
