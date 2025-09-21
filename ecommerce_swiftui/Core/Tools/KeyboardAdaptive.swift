//
//  KeyboardAdaptive.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 18/09/2025.
//

import SwiftUI
import Combine

// Modifier لتحريك الشاشة لما الكيبورد يظهر
struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    private var keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
    private var keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(keyboardWillShow) { notification in
                if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    withAnimation {
                        keyboardHeight = frame.height
                    }
                }
            }
            .onReceive(keyboardWillHide) { _ in
                withAnimation {
                    keyboardHeight = 0
                }
            }
    }
}
