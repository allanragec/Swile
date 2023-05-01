//
//  DateFormatter.swift
//  Transactions
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

extension DateFormatter {
    static let monthDayFormatter = DateFormatter.formatter("yyyy-MM")
    static let dayMonthFormatter = DateFormatter.formatter("dd MMMM")
    static let monthFormatter = DateFormatter.formatter("MMMM")
    
    class func formatter(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter
    }
}
