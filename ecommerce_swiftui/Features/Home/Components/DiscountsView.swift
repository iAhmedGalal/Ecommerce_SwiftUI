//
//  DiscountsView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct DiscountsView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        HomeDividerView(title: "discounts".tr(), showMore: true, route: .dicounts)

        ScrollView(.horizontal) {
            HStack{
                ForEach($viewModel.discountsList) { $item in
                    ItemsView(viewModel: viewModel, item: $item, itemType: .discounts)
                        .padding(4)
                }
            }
        }
    }
}
