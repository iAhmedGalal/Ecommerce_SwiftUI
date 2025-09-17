//
//  NavigationManager.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 16/09/2025.
//

import SwiftUI

struct PageInfo: Hashable {
    let id: Int
    let title: String
}

class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func goToPage(_ page: PageInfo) {
        path.append(page)
    }
    
    func goToPage<T: Hashable>(_ page: T) {
        path.append(page)
    }
    
    func goToUserDetails(_ itemId: Int) {
        path.append(itemId)
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func goToRoot() {
        path.removeLast(path.count)
    }
}
