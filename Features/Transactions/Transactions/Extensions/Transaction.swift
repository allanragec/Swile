//
//  Transaction.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation
import TransactionsAPI

extension TransactionsAPI.Transaction {
    var dateMonth: String {
        DateFormatter.monthDayFormatter.string(from: self.date)
    }
}
