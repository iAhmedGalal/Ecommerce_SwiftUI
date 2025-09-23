//
//  NewItemsView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct NewItemsView: View {
    var newItemsList: [ItemsModel]

    var body: some View {
        HomeDividerView(title: "recentlyAdded".tr(), showMore: true, route: .newItems)
        
        ScrollView(.vertical) {
            VStack{
                ForEach(newItemsList) { item in
                    ItemsVerticalView(item: item)
                        .padding(4)
                }
            }
        }
    }
}
