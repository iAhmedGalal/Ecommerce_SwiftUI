//
//  DiscountTagComponent.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 14/09/2025.
//

import SwiftUI

struct DiscountTagComponent: View {
    let discount: String
    let discounType: Int

    var body: some View {
        ZStack(alignment: .center) {

            Image(.discount)
                .scaledToFit()
            
            VStack {
                Text(discount)
                    .foregroundColor(.white)
                    .font(.jfFont(size: 16))
                
                Text(discounType == 0 ? "%" : "L.B")
                    .foregroundColor(.white)
                    .font(.jfFont(size: 16))
            }
        
        }
    }
}
