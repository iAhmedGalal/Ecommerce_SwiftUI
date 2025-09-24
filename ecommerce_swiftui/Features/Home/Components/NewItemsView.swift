//
//  NewItemsView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct NewItemsView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        HomeDividerView(title: "recentlyAdded".tr(), showMore: true, route: .newItems)
        
        ScrollView(.vertical) {
            VStack{
                ForEach($viewModel.newItemsList) { $item in
                    ItemsVerticalView(viewModel: viewModel, item: $item, itemType: .newItems)
                        .padding(4)
                }
            }
        }
    }
}
