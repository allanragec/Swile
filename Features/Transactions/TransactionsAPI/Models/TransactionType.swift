//
//  TransactionType.swift
//  TransactionsAPI
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

public enum TransactionType: String, Decodable {
    case donation
    case mealVoucher = "meal_voucher"
    case gift
    case mobility
    case payment
}
