//
//  NewItemsView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct NewItemsView: View {
    var newItemsList: [ItemsModel]
    @State private var path: [Int] = [] // Nothing on the stack by default.

    var body: some View {
        HomeDividerView(title: "New Items", showMore: true)
        
        NavigationStack {
            ScrollView(.vertical) {
                VStack{
                    ForEach(newItemsList) { item in
                        ItemsVerticalView(item: item)
                            .padding(4)
                            .navigationDestination(for: Int.self) { itemId in
                                ItemDetailsView(itemId: itemId)
                            }
                    }
                }
            }
        }

    }
}
