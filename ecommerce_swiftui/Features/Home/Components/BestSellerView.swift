//
//  BestSellerView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct BestSellerView: View {
    var bestSellerList: [ItemsModel]
    
    var body: some View {
        HomeDividerView(title: "bestSeller".tr(), showMore: true, route: .bestSeller)
        
        ScrollView(.horizontal) {
            HStack{
                ForEach(bestSellerList) { item in
                    ItemsView(item: item)
                        .padding(4)
                }
            }
        }        
    }
}
