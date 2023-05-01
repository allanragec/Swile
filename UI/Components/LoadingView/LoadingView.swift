//
//  LoadingView.swift
//  Swile
//
//  Created by Allan Melo on 30/04/23.
//

import Foundation
import SwiftUI

public struct LoadingView<Content>: View where Content: View {
    @Binding var isRunning: Bool
    private let title: String
    private var content: () -> Content
    
    public init(
        isRunning: Binding<Bool>,
        title: String = "Loading...",
        content: @escaping () -> Content
    ) {
        self._isRunning = isRunning
        self.title = title
        self.content = content
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isRunning)
                    .blur(radius: self.isRunning ? 3 : 0)

                VStack {
                    Text(title)
                        .foregroundColor(.white)
                    ProgressView()
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isRunning ? 1 : 0)
            }
        }
    }

}
