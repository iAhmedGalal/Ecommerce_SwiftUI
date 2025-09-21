//
//  AuthManager.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    var token: String {
        return SessionManager.shared.currentUser?.token ?? ""
    }
}
