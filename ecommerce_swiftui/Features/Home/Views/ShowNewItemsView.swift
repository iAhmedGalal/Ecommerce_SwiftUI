//
//  ShowNewItemsView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

struct ShowNewItemsView: View {
    @StateObject private var viewModel = HomeViewModel()
  
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                VStack{
                    ForEach(viewModel.newItemsList) { item in
                        ItemsVerticalView(viewModel: viewModel, item: item, itemType: .newItems)
                            .padding(4)
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
            .customNavigation(title: "recentlyAdded".tr(), showBackBtn: true)
            .onAppear {
                viewModel.fetchNewItems()
            }
            
            if viewModel.errorMessage != nil {
                NoItemsView()
            }
        }
    }
}

#Preview {
    ShowNewItemsView()
}
