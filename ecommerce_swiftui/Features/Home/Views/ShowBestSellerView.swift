//
//  ShowBestSellerView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

struct ShowBestSellerView: View {
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
                    ForEach($viewModel.bestSellerList) { $item in
                        ItemsView(viewModel: viewModel, item: $item, itemType: .bestSeller)
                            .padding(4)
                            .onAppear {
                                viewModel.loadMoreBestSellerIfNeeded(currentItem: item)
                            }
                    }
                }
                .padding(.top, 8)
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .padding(.vertical)
                }
            }
            .customNavigation(title: "bestSeller".tr(), showBackBtn: true)
            .onAppear {
                viewModel.fetchBestSeller(page: viewModel.bestSellerPage)
            }
            
            if viewModel.errorMessage != nil {
                NoItemsView()
            }
        }
    }
}

#Preview {
    ShowBestSellerView()
}
