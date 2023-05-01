//
//  TransactionItemImageViewModel.swift
//  Transactions
//
//  Created by Allan Melo on 01/05/23.
//

import SwiftUI
import TransactionsAPI

class TransactionItemImageViewModel: ObservableObject {
    let transaction: TransactionsAPI.Transaction
    
    init(_ transaction: TransactionsAPI.Transaction) {
        self.transaction = transaction
    }
    
    var largeIconName: String {
        "icon_large_\(transaction.largeIcon.category.rawValue)"
    }
    
    var largeIconURL: String? {
        transaction.largeIcon.url
    }
    
    var smallIconURL: String? {
        transaction.smallIcon.url
    }
    
    var smallIconName: String {
        "icon_small_\(transaction.smallIcon.category.rawValue)"
    }
    
    var largeIconBackgrounColor: Color {
        return getBackgroundColor()
    }
    
    var largeIconBorderColor: Color {
        return getBorderColor()
    }
    
    func getBackgroundColor() -> Color {
        switch transaction.largeIcon.category {
        case .sushi:
            return Color(hex: 0xFFEBD4)
        case .computer:
            return Color(hex: 0xFEE0F0)
        case .mealVoucher:
            return Color(hex: 0xFFEBD4)
        case .mobility, .train:
            return Color(hex: 0xFEE0E1)
        case .burger, .bakery, .supermarket:
            return Color(hex: 0xFFEBD4)
        case .payment, .donation, .gift:
            return .white
        }
    }
    
    func getBorderColor() -> Color {
        switch transaction.largeIcon.category {
        case .sushi:
            return Color(hex: 0xFD9B28, alpha: 0.06)
        case .computer:
            return Color(hex: 0xFC63B6, alpha: 0.06)
        case .mealVoucher:
            return Color(hex: 0xFC63B6, alpha: 0.06)
        case .mobility, .train:
            return Color(hex: 0xFEE0E1)
        case .burger, .bakery, .supermarket:
            return Color(hex: 0xFD9B28, alpha: 0.06)
        case .payment, .donation, .gift:
            return Color(hex: 0x000000, alpha: 0.06)
        }
    }
    
}

