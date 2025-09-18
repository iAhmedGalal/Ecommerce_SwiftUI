//
//  CheckBoxView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 18/09/2025.
//

import SwiftUI

struct CheckBoxView: View {
    @State private var isChecked: Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark" : "checkmark")
                    .foregroundColor(isChecked ? .dark : .white)
                    .font(.system(size: 20))
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
            }
        }
    }
}
