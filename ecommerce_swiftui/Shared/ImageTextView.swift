//
//  ImageTextView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 16/09/2025.
//

import SwiftUI

struct ImageTextView: View {
    var image: String
    var name: String
    var addFrame: Bool = false
    
    var body: some View {
        VStack(spacing: 8) {
            CachedAsyncImageView(url: image)
                .if(addFrame) { $0.frame(width: 120, height: 120) }
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                .padding(8)
            
            Text(name)
                .font(.jfFont(size: 16))
        }
    }
}
