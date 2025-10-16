//
//  PickerStyle.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 16/10/2025.
//

import SwiftUI

struct PickerStyle: ViewModifier {
    var isSelected = true

    func body(content: Content) -> some View {
        content
            .foregroundStyle(isSelected ? .white : .black)
//            .padding(.horizontal)
//            .padding(.vertical, 8)
            .lineLimit(1)
//            .background(
//                Capsule()
//                    .fill(isSelected ? Color.accentColor : .white)
//            )
//            .overlay(
//                Capsule()
//                    .stroke(Color.accentColor, lineWidth: 0.5)
//            )
    }
}

extension View {
    func pickerTextStyle(isSelected: Bool) -> some View {
        modifier(PickerStyle(isSelected: isSelected))
    }
}
