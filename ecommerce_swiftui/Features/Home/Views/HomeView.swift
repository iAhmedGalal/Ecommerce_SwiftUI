//
//  HomeView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {        
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    SliderView(sliderList: viewModel.sliderList)
                    CategoriesView(categoriesList: viewModel.categoriesList)
                    
                    if (viewModel.companiesList.isEmpty == false) {
                        CompaniesView(companisList: viewModel.companiesList)
                    }
                    
                    if (viewModel.discountsList.isEmpty == false) {
                        DiscountsView(discountsList: viewModel.discountsList, viewModel: viewModel)
                    }
                    
                    if (viewModel.bestSellerList.isEmpty == false) {
                        BestSellerView(bestSellerList: viewModel.bestSellerList, viewModel: viewModel)
                    }
                    
                    if (viewModel.newItemsList.isEmpty == false) {
                        NewItemsView(newItemsList: viewModel.newItemsList, viewModel: viewModel)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            viewModel.fetchSlider()
            viewModel.fetchCategories()
            viewModel.fetchCompanies()
            viewModel.fetchDiscounts(page: 1)
            viewModel.fetchBestSeller(page: 1)
            viewModel.fetchNewItems()
        }

    }
}

#Preview {
    HomeView()
}
