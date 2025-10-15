//
//  SearchView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 14/10/2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @StateObject private var homeViewModel = HomeViewModel()

    @FocusState private var focusedField: String?
    
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                IconTextField(
                    placeHolder: "searchForItem".tr(),
                    icon: "",
                    text: $viewModel.searchTF,
                    focusedField: _focusedField
                )
                .padding(.top, 8)
                
                ColoredButton(
                    title: "search".tr(),
                    showArrow: false, isGrediant: true
                ) {
                    viewModel.fetchSearchResults(page: 1)
                }
                
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach($viewModel.itemsList) { $item in
                        ItemsView(viewModel: homeViewModel, item: $item, itemType: .search)
                            .padding(4)
                            .onAppear {
                                viewModel.loadMoreItemsIfNeeded(currentItem: item)
                            }
                    }
                }
                .padding(.top, 8)
                
                if viewModel.isLoading {
                    LoadingView()
                }
                
                if viewModel.errorMessage != nil {
                    NoItemsView()
                }
            }
            .customNavigation(title: "search".tr(), showBackBtn: true)
        }
    }
}
