//
//  TransactionAmount.swift
//  TransactionsAPI
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

public struct TransactionAmount: Decodable {
    public let value: Decimal
    public let currency: TransactionCurrency
    
    public init(
        value: Decimal,
        currency: TransactionCurrency
    ) {
        self.value = value
        self.currency = currency
    }
}
