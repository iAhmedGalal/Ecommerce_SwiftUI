//
//  ItemsView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct ItemsView: View {
    @EnvironmentObject var nav: NavigationManager

    var item: ItemsModel

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                CachedAsyncImageView(url: item.img ?? "")
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(8, corners: [.topRight, .topLeft])

                HStack(alignment: .top) {
                    Button {
                        nav.goToUserDetails(item.id ?? 0)
                    } label: {
                        Image(AppAssets.favorite)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(8)
                            .background(Color(AppColors.greyLight))
                            .foregroundColor(Color.red)
                            .clipShape(Circle())
                    }
   
                    
                    Spacer()
                    
                    if item.unitsArr?.first?.has_discount == 1{
                        DiscountTagComponent(
                            discount: item.unitsArr?.first?.discount ?? "",
                            discounType: item.unitsArr?.first?.discount_type ?? 0
                        )
                    }
                }
                .padding(10)
            }

            Text(item.itemName ?? "")
                .font(.jfFont(size: 16))
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(item.unitsArr?.first?.unit_name ?? "")
                        .font(.jfFont(size: 16))
                    
                    if item.unitsArr?.first?.has_discount == 1 {
                        Text(item.unitsArr?.first?.sale_price ?? "")
                            .font(.jfFont(size: 16))
                            .strikethrough()
                    }
                    
                    Text(item.unitsArr?.first?.new_price ?? "")
                        .font(.jfFont(size: 16))
                }
                .padding(.horizontal, 8)
                
                Spacer()
                
                Button {
                    nav.goToUserDetails(item.id ?? 0)
                }
                label: {
                  Image(AppAssets.cart3)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(12)
                .background(Color(AppColors.grey))
                .cornerRadius(8, corners: [.topLeft, .bottomRight])

            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 3)
    }
}
