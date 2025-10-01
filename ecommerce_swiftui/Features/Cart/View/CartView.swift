//
//  CartView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 01/10/2025.
//
import SwiftUI
import CoreData

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()
    
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            VStack {
                List {
                    ForEach($viewModel.cartItems) { $item in
                        HStack {
                            Text(item.name ?? "")
                                .font(.jfFont(size: 18))
                            Spacer()
                            Stepper("\(item.selectedQuantity ?? 0)", value: Binding(
                                get: { Int(item.selectedQuantity ?? 0) },
                                set: { newValue in
                                    viewModel.updateQuantity(productId: item.id ?? 0, quantity: newValue)
                                }
                            ), in: 1...100)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let item = viewModel.cartItems[index]
                            viewModel.removeItem(productId: item.id ?? 0)
                        }
                    }
                }
                
                Text("إجمالي الكمية: \(viewModel.totalItems())")
                    .font(.headline)
                    .padding()
            }
            .customNavigation(title: "cart".tr(), showBackBtn: true)
        }
    }
}
