//
//  Router.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 21/09/2025.
//

import Foundation
import Observation
import SwiftUI

enum AppRoutes: Hashable {
    case splash
    case main
    case login
    case register
    case itemDetailds(Int)
    case bestSeller
    case dicounts
    case newItems
    case profile
    case companies
    case categories
    case favourites
    case aboutUs
    case terms
    case contactUs
    
}

@Observable
class Router {
    var path = NavigationPath()
    
    func push(_ page: AppRoutes) {
        path.append(page)
    }
    
    func pushAndPop(_ page: AppRoutes) {
        path.removeLast(path.count)
        path.append(page)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

struct RouterViewModifier: ViewModifier {
    @State private var router = Router()
    
    private func routeView(for route: AppRoutes) -> some View {
        Group {
            switch route {
                
            case .splash:
                SplashView()
                
            case .main:
                HomeNavView()
                
            case .login:
                LoginView()
                
            case .register:
                RegisterView()
                
            case .itemDetailds(let itemId):
                ItemDetailsView(itemId: itemId)
                
            case .bestSeller:
                ShowBestSellerView()
                
            case .dicounts:
                ShowDiscountsView()

            case .newItems:
                ShowNewItemsView()

            case .profile:
                ProfileView()
                
            case .companies:
                ShowCompaniesView()
                
            case .categories:
                ShowCategoriesView()
                
            case .favourites:
                FavouritesView()
                
            case .aboutUs:
                StaticPagesView()
                
            case .terms:
                StaticPagesView()
                
            case .contactUs:
                ContactUsView()
            }
        }
        .environment(router)
    }
    
    func body(content: Content) -> some View {
        NavigationStack(path: $router.path) {
            content
                .environment(router)
                .navigationDestination(for: AppRoutes.self) { route in
                    routeView(for: route)
                }
        }
    }
}
