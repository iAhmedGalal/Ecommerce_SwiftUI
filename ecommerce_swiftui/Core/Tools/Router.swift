//
//  Router.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 21/09/2025.
//

import Foundation
import Observation
import SwiftUI
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // مهم: اسم الـ container لازم يطابق اسم الـ .xcdatamodeld
        container = NSPersistentContainer(name: "ecommerce")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("❌ Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}


enum AppRoutes: Hashable {
    case splash
    case main
    case login
    case forgetPassword
    case resetPassword(String)
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
    case cart
    
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
    let persistenceController = PersistenceController.shared

    private func routeView(for route: AppRoutes) -> some View {
        Group {
            switch route {
                
            case .splash:
                SplashView()
                
            case .main:
                HomeNavView()
                
            case .login:
                LoginView()
                
            case .forgetPassword:
                ForgetPasswordView()
                
            case .resetPassword(let email):
                ResetPasswordView(email: email)
                
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
                StaticPagesView(pageType: .about)
                
            case .terms:
                StaticPagesView(pageType: .terms)
                
            case .contactUs:
                ContactUsView()
                
            case .cart:
                CartView(context: persistenceController.container.viewContext)
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
