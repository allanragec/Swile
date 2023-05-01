//
//  AppPreferences.swift
//  Components
//
//  Created by Allan Melo on 01/05/23.
//

import SwiftUI

public struct AppPreferences: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .colorScheme(.light)
    }
}
