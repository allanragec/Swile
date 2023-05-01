//
//  TransactionCurrency.swift
//  TransactionsAPI
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

public struct TransactionCurrency: Decodable {
    public let iso3: String
    public let symbol: String
    public let title: String
    
    public init(
        iso: String,
        symbol: String,
        title: String
    ) {
        self.iso3 = iso
        self.symbol = symbol
        self.title = title
    }
}
