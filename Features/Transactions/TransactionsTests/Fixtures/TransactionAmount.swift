//
//  TransactionAmount.swift
//  TransactionsTests
//
//  Created by Allan Melo on 03/05/23.
//

import TransactionsAPI

extension TransactionAmount {
    static func fixture(
        value: Decimal = 10,
        currency: TransactionCurrency = .fixture()
    ) -> Self {
        .init(
            value: value,
            currency: currency
        )
    }
}
