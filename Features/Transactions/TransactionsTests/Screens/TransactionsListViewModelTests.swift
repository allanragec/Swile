//
//  TransactionsListViewModelTests.swift
//  TransactionsTests
//
//  Created by Allan Melo on 02/05/23.
//

import XCTest
@testable import TransactionsAPI
@testable import Transactions

final class TransactionsListViewModelTests: XCTestCase {
    fileprivate func serviceMock() -> TransactionsServiceMock {
        TransactionsServiceMock()
    }
    
    fileprivate func sut(service: TransactionsServicing) -> TransactionsListViewModel {
        .init(service: service)
    }
    
    func testGetTransactions_WhenServiceReturnsValidTransactions_ShouldFillContent() {
        let serviceMock = serviceMock()
        let sut = sut(service: serviceMock)
        
        serviceMock.result = .success(
            .init(transactions: [
                .fixture(),
                .fixture()
        ]))
        
        sut.getTransactions()
        XCTAssertEqual(sut.sections.count, 1)
    }
    
    func testGetTransactions_WhenServiceNotReturnValidTransactions_ShouldShowError() {
        let serviceMock = serviceMock()
        let sut = sut(service: serviceMock)
        
        serviceMock.result = .failure(TransactionsServiceMock.TransactionError.generic)
        
        sut.getTransactions()
        XCTAssertEqual(sut.sections.count, 0)
        XCTAssertNotNil(sut.toast)
    }
}

fileprivate class TransactionsServiceMock: TransactionsServicing {
    var transactionResult: TransansactionsResult = .init(transactions: [])
    var result: Result<TransansactionsResult, Error> = .failure(TransactionError.generic)
    
    enum TransactionError: Error {
        case generic
    }
    
    func getTransactions(completion: @escaping TransactionListCompletion) {
        completion(result)
    }
    
    func getTransactionsAsync() async throws -> TransansactionsResult {
        return transactionResult
    }
}
