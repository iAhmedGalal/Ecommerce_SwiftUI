//
//  AddToCartDialogView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 13/10/2025.
//

import SwiftUI

struct AddToCartDialogView: View {
    @Binding var item: ItemsModel
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CartViewModel
    
//    @State var selectedUnit: UnitsModel? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text(item.itemName ?? "")
                    .font(.jfFont(size: 18))
                
                CachedAsyncImageView(url: item.img ?? "")
                    .frame(width: 150, height: 150)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
                
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

//                UnitsMenuView(
//                    unitsList: item.unitsArr ?? [],
//                    selectedUnit: $selectedUnit
//                )
//                .padding()
//                .background(AppColors.greyWhite)
//                .clipShape(RoundedRectangle(cornerRadius: 32))
                
                Text("notes".tr())
                    .font(.jfFont(size: 18))
                
                TextEditor(text: $viewModel.notesTF)
                    .font(.jfFont(size: 18))
                    .padding(12)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
                    .padding(.horizontal, 16)

                HStack {
                    ColoredButton(
                        title: "addToCart".tr(),
                        showArrow: false, isGrediant: false
                    ) {
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    ColoredButton(
                        title: "goToCart".tr(),
                        showArrow: false, isGrediant: false
                    ) {
                        
                    }
                    .frame(maxWidth: .infinity)
                }
                
            }
        }
        .padding(8)
    }
}
