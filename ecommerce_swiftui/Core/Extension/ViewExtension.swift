//
//  ViewExtension.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 14/09/2025.
//

import SwiftUI

struct CustomCorners: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CustomCorners(radius: radius, corners: corners))
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func toastView(toast: Binding<Toast?>) -> some View {
      self.modifier(ToastModifier(toast: toast))
    }
    
    func keyboardAdaptive() -> some View {
        self.modifier(KeyboardAdaptive())
    }
    
    func router() -> some View {
        modifier(RouterViewModifier())
    }
    
    func customNavigation(title: String, router: Router, showBackBtn: Bool) -> some View {
        self.modifier(CustomNavigationModifier(title: title, router: router, showBackBtn: showBackBtn))
    }
}
