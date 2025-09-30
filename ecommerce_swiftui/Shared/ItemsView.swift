//
//  ItemsView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct ItemsView: View {
    @Environment(Router.self) var router
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject private var cartViewModel = CartViewModel(context: PersistenceController.shared.container.viewContext)

    @Binding var item: ItemsModel
    var itemType: ItemListType

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                CachedAsyncImageView(url: item.img ?? "")
                    .frame(width: 200, height: 200)
                    .cornerRadius(8, corners: [.topRight, .topLeft])

                HStack(alignment: .top) {
                    Button {
                        let newFav = !(item.fav ?? false)
                        viewModel.updateFavoriteIcon(itemId: item.id ?? 0, isFav: newFav, in: itemType)
                    } label: {
                        Image(item.fav ?? false ? AppAssets.favoriteSelect : AppAssets.favorite)
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
                    cartViewModel.addItem(item: item, selectedQty: 3, unitIndex: 0)
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
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .onTapGesture {
            router.push(.itemDetailds(item.id ?? 0))
        }
    }
}
