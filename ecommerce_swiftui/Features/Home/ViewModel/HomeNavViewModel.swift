//
//  HomeNavViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

class HomeNavViewModel: ObservableObject {
    @Published var navPages: [NavPagesModel] = [
        NavPagesModel(id: 0, title: "home".tr(), image: AppAssets.homeGrey),
        NavPagesModel(id: 1, title: "myOrders".tr(), image: AppAssets.bagGrey),
        NavPagesModel(id: 2, title: "notifications".tr(), image: AppAssets.ball),
        NavPagesModel(id: 3, title: "more".tr(), image: AppAssets.moreGrey),
    ]
    
    @Published var pagesViews: [AnyView] = [
        AnyView(HomeView()),
        AnyView(OrdersView()),
        AnyView(NotificationsView()),
        AnyView(MenuView()),
    ]
    
    @Published var selectedIndex: Int = 0
    @Published var maxHeight: Double = 80

}
