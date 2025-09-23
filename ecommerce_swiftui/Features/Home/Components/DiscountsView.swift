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
        HomeDividerView(title: "discounts".tr(), showMore: true, route: .dicounts)

        ScrollView(.horizontal) {
            HStack{
                ForEach(discountsList) { item in
                    ItemsView(item: item)
                        .padding(4)
                        .onTapGesture {
                            
                        }
                }
            }
        }
    }
}
