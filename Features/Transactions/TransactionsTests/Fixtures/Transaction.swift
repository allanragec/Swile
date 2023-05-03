//
//  Transaction.swift
//  TransactionsTests
//
//  Created by Allan Melo on 03/05/23.
//

import TransactionsAPI

extension Transaction {
    static func fixture(
        name: String = "Sushi",
        type: TransactionType = .mobility,
        date: Date = Date(),
        message: String? = "XYZ",
        amount: TransactionAmount = .fixture(),
        smallIcon: TransactionIcon = .fixture(),
        largeIcon: TransactionIcon = .fixture()
    ) -> Self {
        .init(
            name: name,
            type: type,
            date: date,
            message: message,
            amount: amount,
            smallIcon: smallIcon,
            largeIcon: largeIcon
        )
    }
}
