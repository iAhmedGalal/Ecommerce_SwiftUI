//
//  ItemDetailsView.swift
//  ecommerce
//
//  Created by Ahmed Galal on 14/09/2025.
//

import SwiftUI

struct ItemDetailsView: View {
    @State var itemId: Int
    
    @StateObject private var viewModel = ItemDetailsViewModel()

    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ZStack(alignment: .topLeading) {
                        CachedAsyncImageView(url: viewModel.item.img ?? "")
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        HStack(alignment: .top) {
                            Button {

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
                            
                            if viewModel.item.unitsArr?.first?.has_discount == 1{
                                DiscountTagComponent(
                                    discount: viewModel.item.unitsArr?.first?.discount ?? "",
                                    discounType: viewModel.item.unitsArr?.first?.discount_type ?? 0
                                )
                            }
                        }
                        .padding(10)
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)

                    Text(viewModel.item.itemName ?? "")
                        .font(.jfFontBold(size: 20))
                        .lineLimit(2)
                    
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text(viewModel.item.unitsArr?.first?.unit_name ?? "")
                                .font(.jfFont(size: 16))
                            
                            if viewModel.item.unitsArr?.first?.has_discount == 1 {
                                Text(viewModel.item.unitsArr?.first?.sale_price ?? "")
                                    .font(.jfFont(size: 16))
                                    .strikethrough()
                            }
                            
                            Text(viewModel.item.unitsArr?.first?.new_price ?? "")
                                .font(.jfFont(size: 16))
                        }
                        .padding(.horizontal, 8)
                        
                        Spacer()
                        
                        Button {
                            
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
                .padding()
            }
        }
        .customNavigation(title: viewModel.item.itemName ?? "", showBackBtn: true)
        .onAppear {
            viewModel.getItemDetails(id: itemId)
        }
    }
}
