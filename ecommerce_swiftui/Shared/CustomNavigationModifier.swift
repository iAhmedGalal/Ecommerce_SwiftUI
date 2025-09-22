//
//  CustomNavigationModifier.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 22/09/2025.
//

import SwiftUI

struct CustomNavigationModifier: ViewModifier {
    let title: String
    let router: Router
    var showBackBtn: Bool = true
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                if (showBackBtn) {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            router.pop()
                        } label: {
                            Image(systemName: LocalizationManager.shared.language == .arabic ? "chevron.right" : "chevron.left")
                                .fontWeight(.semibold)
                        }
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.jfFont(size: 20))
                        .foregroundStyle(.accent)
                }
            }
    }
}
