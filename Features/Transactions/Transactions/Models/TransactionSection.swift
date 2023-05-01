//
//  TransactionSection.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation
import TransactionsAPI

struct TransactionSection: Identifiable {
    var id: Int { dateMonth.hashValue }
    
    let dateMonth: String
    let transactions: [TransactionsAPI.Transaction]
    var month: String {
        guard let date = DateFormatter.monthDayFormatter.date(from: dateMonth) else {
            return dateMonth
        }
        let formatter = DateFormatter.monthFormatter
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: date).capitalized
    }
}
