//
//  HomeNavView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 18/09/2025.
//

import SwiftUI

struct HomeNavView: View {
    @StateObject private var viewModel = HomeNavViewModel()
    @Environment(Router.self) var router
    private let gradientColors = [Color(AppColors.gradientColor1), Color(AppColors.gradientColor2)]

    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            VStack {
                switch viewModel.selectedIndex {
                case 0:
                    HomeView()
                case 1:
                    OrdersView()
                case 2:
                    NotificationsView()
                case 3:
                    MenuView()
                default:
                    EmptyView()
                }
                
                HStack(spacing: 0) {
                    ForEach(viewModel.navPages) { nav in
                        HomeNavItem(
                            title: nav.title,
                            image: nav.image,
                            index: nav.id,
                            currentIndex: $viewModel.selectedIndex
                        )
                        .frame(maxWidth: .infinity, maxHeight: viewModel.maxHeight)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: viewModel.selectedIndex == nav.id ? gradientColors : [AppColors.white]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .background(Color(AppColors.white))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 8)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        router.push(.cart)
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
                
                ToolbarItem(placement: .principal) {
                    Text(viewModel.navPages[viewModel.selectedIndex].title)
                        .font(.jfFont(size: 20))
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
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}

#Preview {
    HomeNavView()
}
