//
//  HomeNavView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 18/09/2025.
//

import SwiftUI

struct HomeNavView: View {
    @State var currentIndex: Int = 0
    var maxHeight: Double = 80
    
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            VStack {
                if (currentIndex == 0) {
                    HomeView()
                }
                
                if (currentIndex == 1) {
                    OrdersView()
                }
                
                if (currentIndex == 2) {
                    NotificationsView()
                }
                
                if (currentIndex == 3) {
                    MenuView()
                }
                
                HStack(spacing: 0) {
                    HomeNavItem(
                        title: "Home",
                        image: AppAssets.homeGrey,
                        index: 0,
                        currentIndex: $currentIndex
                    )
                    .frame(maxWidth: .infinity, maxHeight: maxHeight)
                    .background(Color(currentIndex == 0 ? AppColors.darkPrimary : AppColors.white))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    HomeNavItem(
                        title: "Orders",
                        image: AppAssets.bagGrey,
                        index: 1,
                        currentIndex: $currentIndex
                    )
                    .frame(maxWidth: .infinity, maxHeight: maxHeight)
                    .background(Color(currentIndex == 1 ? AppColors.darkPrimary : AppColors.white))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    HomeNavItem(
                        title: "Notifications",
                        image: AppAssets.ball,
                        index: 2,
                        currentIndex: $currentIndex
                    )
                    .frame(maxWidth: .infinity, maxHeight: maxHeight)
                    .background(Color(currentIndex == 2 ? AppColors.darkPrimary : AppColors.white))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    HomeNavItem(
                        title: "More",
                        image: AppAssets.moreGrey,
                        index: 3,
                        currentIndex: $currentIndex
                    )
                    .frame(maxWidth: .infinity, maxHeight: maxHeight)
                    .background(Color(currentIndex == 3 ? AppColors.darkPrimary : AppColors.white))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                }
                .background(Color(AppColors.white))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 8)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        ZStack(alignment: .topLeading) {
                            Image(AppAssets.cart)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                            
                            Text("99")
                                .font(.jfFont(size: 14))
                                .padding(4)
                                .foregroundColor(.white)
                                .background(Color(AppColors.red))
                                .clipShape(Circle())
                                .padding(-8)
                        }
                    }
                }
                                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(AppAssets.moreGrey)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("Home Screen")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}

struct HomeNavItem: View {
    var title: String
    var image: String
    var index: Int
    @Binding var currentIndex: Int
    
    var body: some View {
        Button {
            currentIndex = index
        } label: {
            VStack(spacing: 8) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(currentIndex == index ? .white : .gray)

                Text(title)
                    .font(.jfFont(size: 14))
                    .foregroundStyle(currentIndex == index ? .white : .gray)
            }
        }
    }
}

#Preview {
    HomeNavView()
}
