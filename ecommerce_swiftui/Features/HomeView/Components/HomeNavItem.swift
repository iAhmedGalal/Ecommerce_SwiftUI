//
//  HomeNavItem.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

struct HomeNavItem: View {
    var title: String
    var image: String
    var index: Int
    @Binding var currentIndex: Int
    
    var body: some View {
        Button {
            currentIndex = index
        } label: {
            VStack(spacing: 8) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(currentIndex == index ? .white : .gray)

                Text(title)
                    .font(.jfFont(size: 14))
                    .foregroundStyle(currentIndex == index ? .white : .gray)
            }
        }
    }
}
