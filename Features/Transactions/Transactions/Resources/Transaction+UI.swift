//
//  Transaction.swift
//  Transactions
//
//  Created by Allan Melo on 01/05/23.
//

import Foundation
import SwiftUI
import TransactionsAPI

extension TransactionsAPI.Transaction {
    var largeIconName: String {
        "icon_large_\(largeIcon.category.rawValue)"
    }
    
    var largeIconURL: String? {
        largeIcon.url
    }
    
    var smallIconURL: String? {
        smallIcon.url
    }
    
    var smallIconName: String {
        "icon_small_\(smallIcon.category.rawValue)"
    }
    
    func getBackgroundColor() -> Color {
        switch largeIcon.category {
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
            return Color(hex: 0x000000, alpha: 0.06)
        }
    }
    
    func getBorderColor() -> Color {
        switch largeIcon.category {
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
