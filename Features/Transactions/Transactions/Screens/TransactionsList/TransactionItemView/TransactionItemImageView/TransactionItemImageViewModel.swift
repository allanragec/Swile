//
//  TransactionItemImageViewModel.swift
//  Transactions
//
//  Created by Allan Melo on 01/05/23.
//

import SwiftUI
import TransactionsAPI

class TransactionItemImageViewModel: ObservableObject {
    var transaction: TransactionsAPI.Transaction
    
    init(_ transaction: TransactionsAPI.Transaction) {
        self.transaction = transaction
    }
    
    var largeIconName: String {
        transaction.largeIconName
    }
    
    var largeIconURL: String? {
        transaction.largeIconURL
    }
    
    var smallIconURL: String? {
        transaction.smallIconURL
    }
    
    var smallIconName: String {
        "icon_small_\(transaction.smallIcon.category.rawValue)"
    }
    
    var largeIconBackgrounColor: Color {
        return transaction.getBackgroundColor()
    }
    
    var largeIconBorderColor: Color {
        return transaction.getBorderColor()
    }
}

