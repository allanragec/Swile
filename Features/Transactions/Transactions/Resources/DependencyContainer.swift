//
//  DependencyContainer.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation
import CoreNetworkingAPI
import DependencyOrchestrator

typealias TransactionsDependencies = HasCodableLoader

final class DependencyContainer: TransactionsDependencies {
    private let orchestrator: DependencyOrchestrator

    lazy var codableLoader: CodableLoaderProtocol = orchestrator.resolve()

    init(orchestrator: DependencyOrchestrator = .shared) {
        self.orchestrator = orchestrator
    }
}
