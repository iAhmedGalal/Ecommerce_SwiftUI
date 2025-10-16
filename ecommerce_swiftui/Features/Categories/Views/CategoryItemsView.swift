//
//  CategoryItemsView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 15/10/2025.
//

import SwiftUI

struct CategoryItemsView: View {
    @State var categoryId: Int

    @StateObject private var viewModel = CategoriesViewModel()
    @StateObject private var homeViewModel = HomeViewModel()

    @State var selectedCat: CategoriesModel?

    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                Text("التصنيفات الرئيسية")
                    .font(.jfFontBold(size: 18))
                    .padding(.top, 8)
                
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(viewModel.categoriesList) { item in
                            ImageTextView(
                                image: item.image ?? "",
                                name: item.name ?? "",
                                addFrame: true
                            )
                            .onTapGesture {
                                viewModel.selectedCategoryId = item.id ?? 0
                                viewModel.selectedCompanyId = 0
                                viewModel.fetchSubCategories()
                                viewModel.fetchCategoryItems(page: 1)
                            }
                        }
                    }
                }
                
                SegmentedPicker(
                    selection: $selectedCat,
                    items: $viewModel.categoriesList,
                    selectionColor: .accent
                ) { item in
                    ImageTextView(
                        image: item.image ?? "",
                        name: item.name ?? "",
                        addFrame: true
                    )
                }
                
//                SegmentedPicker(
//                    selection: $selectedCat,
//                    items: $viewModel.categoriesList,
//                    selectionColor: .accent
//                ) { item in
//                    Text(item.name ?? "")
//                        .font(.jfFont(size: 18))
////                            .onTapGesture {
////                                viewModel.selectedCategoryId = item.id ?? 0
////                                viewModel.selectedCompanyId = 0
////                                viewModel.fetchSubCategories()
////                                viewModel.fetchCategoryItems(page: 1)
////                            }
//                }
                
                if viewModel.subCategoriesList.isEmpty == false {
                    Text("التصنيفات الفرعية")
                        .font(.jfFontBold(size: 18))
                        .padding(.top, 16)
                    
                    SegmentedPicker(
                        selection: $selectedCat,
                        items: $viewModel.subCategoriesList,
                        selectionColor: .accent
                    ) { item in
                        Text(item.name ?? "")
                            .font(.jfFont(size: 18))
                            .onTapGesture {
                                viewModel.selectedCategoryId = item.id ?? 0
                                viewModel.selectedCompanyId = 0
                                viewModel.fetchCategoryItems(page: 1)
                            }
                    }
                    
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(viewModel.subCategoriesList) { item in
                                ImageTextView(
                                    image: item.image ?? "",
                                    name: item.name ?? "",
                                    addFrame: true
                                )
                                .onTapGesture {
                                    viewModel.selectedCategoryId = item.id ?? 0
                                    viewModel.selectedCompanyId = 0
                                    viewModel.fetchCategoryItems(page: 1)
                                }
                            }
                        }
                    }
                }
                
                if viewModel.companiesList.isEmpty == false {
                    Text("الشركات")
                        .font(.jfFontBold(size: 18))
                        .padding(.top, 16)

                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(viewModel.companiesList) { item in
                                ImageTextView(
                                    image: item.image ?? "",
                                    name: item.name ?? "",
                                    addFrame: true
                                )
                                .onTapGesture {
                                    viewModel.selectedCompanyId = item.id ?? 0
                                    viewModel.fetchCategoryItems(page: 1)
                                }
                            }
                        }
                    }
                }
                
                Text("الأسعار")
                    .font(.jfFontBold(size: 18))
                    .padding(.top, 16)
                
                
                Slider(value: $viewModel.itemPriceFrom, in: 0...viewModel.itemPriceTo, step: 1)
                    .padding(.horizontal)
                
                Text("من: \(viewModel.itemPriceFrom, specifier: "%.0f") إلى: \(viewModel.itemPriceTo, specifier: "%.0f") جنيه")
                    .font(.jfFont(size: 16))

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
            .customNavigation(title: "categories".tr(), showBackBtn: true)
            .onAppear {
                viewModel.selectedCategoryId = categoryId

                viewModel.fetchCategories()
                viewModel.fetchCompanies()
                viewModel.fetchSubCategories()
                viewModel.fetchCategoryItems(page: 1)
            }
            
//            if viewModel.isLoading {
//                LoadingView()
//            }
//            
//            if viewModel.errorMessage != nil {
//                NoItemsView()
//            }
        }
    }
}

