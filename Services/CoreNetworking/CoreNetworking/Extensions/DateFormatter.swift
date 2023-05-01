//
//  DateFormatter.swift
//  CoreNetworking
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

extension DateFormatter {
    static let defaultFormatter = DateFormatter.formatter("yyyy-MM-dd'T'HH:mm:ss.SSSXXX")
    static let dayFormatter = DateFormatter.formatter("yyyy-MM-dd")
    
    class func formatter(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter
    }
}
