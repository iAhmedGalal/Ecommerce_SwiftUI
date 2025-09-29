//
//  ShowCategoriesView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

import SwiftUI

struct ShowCategoriesView: View {
    @StateObject private var viewModel = HomeViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.categoriesList) { item in
                        ImageTextView(
                            image: item.image ?? "",
                            name: item.name ?? "",
                            addFrame: true
                        )
                    }
                }
                .padding(.top, 8)
            }
            .customNavigation(title: "categories".tr(), showBackBtn: true)
            .onAppear {
                viewModel.fetchCategories()
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
            
            if viewModel.errorMessage != nil {
                NoItemsView()
            }
        }
    }
}

#Preview {
    ShowCategoriesView()
}
