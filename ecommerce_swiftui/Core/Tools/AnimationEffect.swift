//
//  AnimationEffect.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 16/10/2025.
//

import SwiftUI

struct AnimationEffect: ViewModifier {
    var isSelected = true
    var id: String
    var namespace: Namespace.ID

    func body(content: Content) -> some View {
        if isSelected {
            content.matchedGeometryEffect(id: id, in: namespace)
        } else {
            content
        }
    }
}

extension View {
    func animationEffect(isSelected: Bool, id: String, in namespace: Namespace.ID) -> some View {
        modifier(AnimationEffect(isSelected: isSelected, id: id, namespace: namespace))
    }
}
