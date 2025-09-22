//
//  IconTitleCustomView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 23/09/2025.
//

import SwiftUI

struct IconTitleCustomView: View {
    var title: String = ""
    var icon: String = ""

    let customView: AnyView
    
    var body: some View {
        HStack(spacing: 16) {
            if (icon != "") {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                if !title.isEmpty {
                    Text(title)
                        .font(.jfFont(size: 18))
                        .foregroundColor(AppColors.greyDark)
                }
                
                customView
                    .padding(.top, 8)
            }
            
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
//        .shadow(color: .gray, radius: 2)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}
