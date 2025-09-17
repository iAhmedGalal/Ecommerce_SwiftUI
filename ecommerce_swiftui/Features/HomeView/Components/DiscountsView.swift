//
//  DiscountsView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct DiscountsView: View {
    var discountsList: [ItemsModel]
    
    var body: some View {
        NavigationStack {
            HomeDividerView(title: "Discounts", showMore: true)

            ScrollView(.horizontal) {
                HStack{
                    ForEach(discountsList) { item in
                        ItemsView(item: item)
                            .padding(4)
                    }
                }
            }
        }
    }
}
