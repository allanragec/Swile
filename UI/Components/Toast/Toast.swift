//
//  Toast.swift
//  Components
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation

public struct Toast: Equatable, Hashable {
    var type: ToastStyle
    var title: String
    var message: String
    var duration: Double
    
    public init(
        type: ToastStyle,
        title: String,
        message: String,
        duration: Double = 2
    ) {
        self.type = type
        self.title = title
        self.message = message
        self.duration = duration
    }
    
    public static func == (lhs: Toast, rhs: Toast) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(message)
    }
}
