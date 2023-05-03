//
//  TransactionCurrency.swift
//  TransactionsTests
//
//  Created by Allan Melo on 03/05/23.
//

import TransactionsAPI

extension TransactionCurrency {
    static func fixture(
        iso: String = "EUR",
        symbol: String = "€",
        title: String = "Euro"
    ) -> Self {
        .init(
            iso: iso,
            symbol: symbol,
            title: title
        )
    }
}
