//
//  TransactionDetailsViewModel.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import SwiftUI
import TransactionsAPI

class TransactionDetailsViewModel: ObservableObject {
    let transaction: TransactionsAPI.Transaction
    
    init(_ transaction: TransactionsAPI.Transaction) {
        self.transaction = transaction
    }
    
    var title: String {
        transaction.name
    }
    
    var subtitle: String {
        let formatter = DateFormatter.dayMonthFormatter
        formatter.locale = Locale(identifier: "fr_FR")
        let date = formatter.string(from: transaction.date)
        
        guard let message = transaction.message else {
            return date
        }
        
        return "\(date) ・ \(message)"
    }
    var isPayment: Bool {
        transaction.type == .payment
    }
    
    var paymentPrice: String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        
        guard let value = formatter.string(from: transaction.amount.value as NSNumber) else {
            return "-"
        }
        
        return "+\(value) \(transaction.amount.currency.symbol)"
    }
    
    var price: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        guard let value = formatter.string(from: transaction.amount.value as NSNumber) else {
            return "-"
        }
        
        return "\(value) \(transaction.amount.currency.symbol)"
    }
}

