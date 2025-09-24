//
//  FavouritesView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

struct FavouritesView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
//                    ForEach(viewModel.favList) { item in
//                        ItemsView(item: item)
//                            .padding(4)
//                    }
                }
                .padding(.top, 8)
            }
            .customNavigation(title: "favourites".tr(), showBackBtn: true)
            .onAppear {
                viewModel.fetchFavouritrs()
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .padding(.vertical)
            }
            
            if viewModel.errorMessage != nil {
                NoItemsView()
            }
        }
    }
}

#Preview {
    FavouritesView()
}
