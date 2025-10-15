//
//  CategoriesView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct CategoriesView: View {
    var categoriesList: [CategoriesModel]
    @Environment(Router.self) var router

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        HomeDividerView(title: "categories".tr(), showMore: false)

        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(categoriesList) { category in
                    ImageTextView(
                        image: category.image ?? "",
                        name: category.name ?? "",
                        addFrame: true
                    )
                    .onTapGesture {
                        router.push(.catItems(category.id ?? 0))
                    }
                }
            }
        }
    }
}
