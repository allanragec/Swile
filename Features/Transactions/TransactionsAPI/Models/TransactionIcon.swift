//
//  TransactionIcon.swift
//  TransactionsAPI
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

public struct TransactionIcon: Decodable {
    public let url: String?
    public let category: Category
    
    public init(
        url: String?,
        category: Category
    ) {
        self.url = url
        self.category = category
    }
    
    public enum Category: String, Decodable {
        case sushi
        case computer
        case mealVoucher = "meal_voucher"
        case mobility
        case train
        case burger
        case bakery
        case supermarket
        case payment
        case donation
        case gift
    }
}
