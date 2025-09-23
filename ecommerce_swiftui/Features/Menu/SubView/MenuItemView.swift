//
//  MenuItemView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

struct MenuItemView: View {
    @StateObject private var viewModel = MenuViewModel()
    @Environment(Router.self) var router

    var title: String
    var image: String
    let page: AppRoutes
    
    var isLogout: Bool = false

    var body: some View {
        HStack(spacing: 8) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text(title)
                .font(.jfFont(size: 18))
            
            Spacer()
        }
        .padding()
        .background(Color(AppColors.white))
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .onTapGesture {
            if isLogout {
                viewModel.logout()
            }
            else {
                router.push(page)
            }
        }
    }
}

