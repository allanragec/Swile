//
//  TransactionIcon.swift
//  TransactionsTests
//
//  Created by Allan Melo on 03/05/23.
//

import TransactionsAPI

extension TransactionIcon {
    static func fixture(
        url: String? = nil,
        category: Category = .mobility
    ) -> Self {
        .init(
            url: url,
            category: category
        )
    }
}
