//
//  Transaction.swift
//  TransactionsAPI
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

public struct TransansactionsResult: Decodable {
    public let transactions: [Transaction]
    
    public init(transactions: [Transaction]) {
        self.transactions = transactions
    }
}

public struct Transaction: Decodable, Hashable, Identifiable {
    public var id: Int { hashValue }
    
    public let name: String
    public let type: TransactionType
    public let date: Date
    public let message: String?
    public let amount: TransactionAmount
    public let smallIcon: TransactionIcon
    public let largeIcon: TransactionIcon
    
    public init(
        name: String,
        type: TransactionType,
        date: Date,
        message: String?,
        amount: TransactionAmount,
        smallIcon: TransactionIcon,
        largeIcon: TransactionIcon
    ) {
        self.name = name
        self.type = type
        self.date = date
        self.message = message
        self.amount = amount
        self.smallIcon = smallIcon
        self.largeIcon = largeIcon
    }
    
    public static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
        hasher.combine(date)
    }
    
    public enum CodingKeys: String, CodingKey {
        case name, type, date, message, amount, smallIcon, largeIcon
    }
}
