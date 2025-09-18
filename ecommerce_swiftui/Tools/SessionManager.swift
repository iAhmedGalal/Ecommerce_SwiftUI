//
//  SessionManager.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 17/09/2025.
//

import SwiftUI
import Combine

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var currentUser: UserModel? = nil
    
    private let userKey = "currentUser"
    private init() {
        loadUser() // نحمل اليوزر أوتوماتيك أول ما التطبيق يشتغل
    }
    
    func saveUser(_ user: UserModel) {
        currentUser = user
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        }
    }
    
    func loadUser() {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let user = try? JSONDecoder().decode(UserModel.self, from: data) {
            currentUser = user
        }
    }
    
    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: userKey)
    }
    
    func isLoggedIn() -> Bool {
        return currentUser != nil
    }
}
