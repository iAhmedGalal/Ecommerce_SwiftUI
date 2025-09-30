//
//  CartView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 01/10/2025.
//
import SwiftUI
import CoreData

struct CartView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: CartViewModel
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: CartViewModel(context: context))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.cartItems, id: \.self) { item in
                        HStack {
                            Text(item.name ?? "")
                            Spacer()
                            Stepper("\(item.quantity)", value: Binding(
                                get: { Int(item.quantity) },
                                set: { newValue in
                                    viewModel.updateQuantity(item: item, quantity: newValue)
                                }
                            ), in: 1...100)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let item = viewModel.cartItems[index]
                            viewModel.removeItem(item: item)
                        }
                    }
                }
                
                Text("إجمالي الكمية: \(viewModel.totalItems())")
                    .font(.headline)
                    .padding()
                
                Button("إضافة منتج تجريبي") {
//                    viewModel.addItem(productId: Int.random(in: 1...100), name: "منتج جديد")
                }
                .padding()
            }
            .navigationTitle("السلة (CoreData)")
        }
    }
}
