//
//  ShowCompaniesView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

struct ShowCompaniesView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Environment(Router.self) var router

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
                    ForEach(viewModel.companiesList) { item in
                        ImageTextView(
                            image: item.image ?? "",
                            name: item.name ?? "",
                            addFrame: true
                        )
                        .onTapGesture {
                            router.push(.companyItems(item.id ?? 0))
                        }
                    }
                }
                .padding(.top, 8)
            }
            .customNavigation(title: "companies".tr(), showBackBtn: true)
            .onAppear {
                viewModel.fetchCompanies()
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
    ShowCompaniesView()
}
