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
        NavigationView {
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
                            DiscountsView(discountsList: viewModel.discountsList)
                        }
                        
                        if (viewModel.bestSellerList.isEmpty == false) {
                            BestSellerView(bestSellerList: viewModel.bestSellerList)
                        }
                        
                        if (viewModel.newItemsList.isEmpty == false) {
                            NewItemsView(newItemsList: viewModel.newItemsList)
                        }
                    }
                }
            }
            .navigationDestination(for: String.self) { page in
                ItemDetailsView(itemId: Int(page) ?? 0)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        ZStack(alignment: .topLeading) {
                            Image(AppAssets.cart)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                            
                            Text("99")
                                .font(.jfFont(size: 14))
                                .padding(4)
                                .foregroundColor(.white)
                                .background(Color(AppColors.red))
                                .clipShape(Circle())
                                .padding(-8)
                        }
                    }
                }
                                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(AppAssets.moreGrey)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("Home Screen")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                viewModel.fetchSlider()
                viewModel.fetchCategories()
                viewModel.fetchCompanies()
                viewModel.fetchDiscounts()
                viewModel.fetchBestSeller()
                viewModel.fetchNewItems()
            }
        }

    }
}

#Preview {
    HomeView()
}
