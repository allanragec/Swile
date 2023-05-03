//
//  TransactionDetailsViewModelTests.swift
//  TransactionsTests
//
//  Created by Allan Melo on 02/05/23.
//

import XCTest
@testable import TransactionsAPI
@testable import Transactions

final class TransactionDetailsViewModelTests: XCTestCase {
    fileprivate func sut(transaction: Transaction) -> TransactionDetailsViewModel {
        .init(transaction)
    }
    
    func testTitle_WhenDetailsScreenIsLoaded_ShouldShowTitleCorrectly() {
        let expectedTitle = "Sushi WA"
        let sut = sut(
            transaction: .fixture(name: expectedTitle)
        )
        
        XCTAssertEqual(sut.title, expectedTitle)
    }
    
    func testSubtitle_WhenDetailsScreenIsLoaded_ShouldShowSubtitleCorrectly() {
        let date = Date(timeIntervalSince1970: 1590242591) // 23 May
        let expectedTitle = "23 mai ・ Don à l'arrondi"
        
        let sut = sut(
            transaction: .fixture(
                date: date,
                message: "Don à l'arrondi"
            )
        )
        
        XCTAssertEqual(sut.subtitle, expectedTitle)
    }
    
    func testIsPayment_WhenTransactionIsPayment_ShouldReturnTrue() {
        let sut = sut(
            transaction: .fixture(
                type: .payment
            )
        )
        
        XCTAssertTrue(sut.isPayment)
    }
    
    func testIsPayment_WhenTransactionIsNotPayment_ShouldReturnFalse() {
        let sut = sut(
            transaction: .fixture(
                type: .mobility
            )
        )
        
        XCTAssertFalse(sut.isPayment)
    }
    
    func testPrice_WhenDetailsScreenIsLoaded_ShouldShowPriceCorrectly() {
        let expectedPrice = "15,00 €"
        let sut = sut(
            transaction: .fixture(
                amount: .init(value: 15, currency: .fixture(symbol: "€"))
            )
        )
        
        XCTAssertEqual(sut.price, expectedPrice)
    }
}
