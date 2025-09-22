//
//  ecommerce_swiftuiApp.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

@main
struct ecommerce_swiftuiApp: App {
    @StateObject private var localizationManager = LocalizationManager.shared

    var body: some Scene {
        WindowGroup {
            SplashView()
                .router()
                .environment(\.locale, localizationManager.currentLocale)
                .environment(\.layoutDirection, localizationManager.layoutDirection)
                .environmentObject(localizationManager)
        }
    }
}
