//
//  CompaniesView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct CompaniesView: View {
    var companisList: [CompaniesModel]
    
    var body: some View {
        HomeDividerView(title: "Companies", showMore: false)

        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(companisList) { item in
                    ImageTextView(
                        image: item.image ?? "",
                        name: item.name ?? "",
                        addFrame: true
                    )
                
                }
            }
        }
    }
}
