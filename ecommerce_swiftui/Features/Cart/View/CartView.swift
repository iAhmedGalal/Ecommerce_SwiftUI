//
//  CartView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 01/10/2025.
//
import SwiftUI

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()
    
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ForEach($viewModel.cartItems) { $item in
                        CartItemView(viewModel: viewModel, item: $item)
                    }
                
                    
                    HStack {
                        Text("إجمالي الطلب:")
                            .font(.jfFont(size: 18))
                        Spacer()
                        Text("\(viewModel.totalPrice(), specifier: "%.2f") جنيه")
                            .font(.jfFont(size: 18))
                    }
                    .padding()
                    .background(AppColors.greyWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
                    .background(AppColors.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal)
                    
                    ColoredButton(
                        title: "استكمال الطلب".tr(),
                        showArrow: true,
                        isGrediant: true
                    ) {

                    }
                    
                }
                .customNavigation(title: "cart".tr(), showBackBtn: true)
            }
        }
    }
}

struct CartItemView: View {
    @ObservedObject var viewModel: CartViewModel
    @Binding var item: CartModel
    
    var body: some View {
        HStack {
            ZStack(alignment: .topLeading) {
                CachedAsyncImageView(url: item.image ?? "")
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                
                HStack(alignment: .top) {
                    if item.hasDiscount == 1 {
                        DiscountTagComponent(
                            discount: item.discount ?? "",
                            discounType: item.discountType ?? 0
                        )
                    }
                }
                .padding(10)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text(item.name ?? "")
                    .font(.jfFont(size: 18))
                
                
                HStack {
                    if item.hasDiscount == 1 {
                        Text(item.salePrice ?? "")
                            .font(.jfFont(size: 16))
                            .strikethrough()
                    }
                    
                    Text(item.newPrice ?? "")
                        .font(.jfFont(size: 16))
                }
                
                HStack {
                    HStack {
                        Button {
                            let newValue = Int(item.selectedQuantity ?? 0) + 1
                            viewModel.updateQuantity(cartId: item.cartId ?? "", quantity: newValue)
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(Color.black)
                        }
                        
                        Text("\(item.selectedQuantity ?? 0)")
                            .font(.jfFont(size: 16))
                            .padding(.horizontal, 8)
                        
                        Button {
                            let newValue = Int(item.selectedQuantity ?? 0) - 1
                            viewModel.updateQuantity(cartId: item.cartId ?? "", quantity: newValue)
                        } label: {
                            Image(systemName: "minus")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .padding()
                    .background(AppColors.greyWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 32))

                   
                    Text(item.unitName ?? "")
                        .font(.jfFont(size: 16))
                        .padding()
                        .background(AppColors.greyWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                }
            }
            
            Spacer()
            
            Button {
                viewModel.removeItem(cartId: item.cartId ?? "")
            } label: {
                Image(systemName: "trash")
                    .foregroundStyle(Color.white)
                    .padding(6)
                    .background(AppColors.darkPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
            }
           
        }
        .padding(8)
        .background(AppColors.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 16)
    }
}
