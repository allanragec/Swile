//
//  ImageView.swift
//  Components
//
//  Created by Allan Melo on 01/05/23.
//

import SwiftUI

public struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    public init(withURL url: String) {
        imageLoader = ImageLoader(urlString: url)
    }
    
    public var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            }
            else {
                ProgressView()
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        .aspectRatio(contentMode: .fit)
    }
}
