//
//  View.swift
//  Components
//
//  Created by Allan Melo on 30/04/23.
//

import SwiftUI

public extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
