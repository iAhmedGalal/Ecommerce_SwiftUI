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
    @EnvironmentObject var nav: NavigationManager

//    @State private var itemI: String = ""
//    @State private var unitPrice: Double = 0.0
//    @State private var totalItemPrice: Double = 0.0
//    @State private var totalCartPrice: Double = 0.0
    
//    var itemName: String
//    var imageUrl: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                
                Text(viewModel.item.itemName ?? "")
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                
                AsyncImage(url: URL(string: viewModel.item.img ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 150)
                .cornerRadius(10)
                
                // Dropdown Placeholder
                Text("Units Dropdown")
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                Text("Quantity")
                    .font(.system(size: 16))
                
//                HStack {
//                    Button(action: { selectedQuantity += 1 }) {
//                        Image(systemName: "plus")
//                    }
//                    Text("\(selectedQuantity)")
//                        .frame(minWidth: 40)
//                    Button(action: { if selectedQuantity > 1 { selectedQuantity -= 1 } }) {
//                        Image(systemName: "minus")
//                    }
//                }
//                .padding()
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(20)
                
                Text("Max Quantity: 10")
                
//                PriceText(label: "Unit Price", price: viewModel.item.salePrice ?? "")
//                PriceText(label: "Total Item Price", price: totalItemPrice)
//                PriceText(label: "Total Cart Price", price: totalCartPrice)
                
                Text("Add Notes")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
//                TextEditor(text: $notes)
//                    .frame(height: 100)
//                    .padding()
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(20)
                
                HStack {
                    Button(action: {
                        // Go to cart
                    }) {
                        HStack {
                            Image(systemName: "cart")
                            Text("Go to Cart")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Add to cart
                    }) {
                        HStack {
                            Image(systemName: "cart.badge.plus")
                            Text("Add to Cart")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding()
        }
        .navigationTitle("Item Details")
        .onAppear {
            viewModel.getItemDetails(id: itemId)
        }
    }
}

struct PriceText: View {
    var label: String
    var price: Double
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(String(format: "%.2f", price))
        }
        .padding(.horizontal)
    }
}
