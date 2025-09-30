//
//  IconTextField.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 18/09/2025.
//

import SwiftUI

struct IconTextField: View {
    var title: String = ""
    var placeHolder: String = ""
    var icon: String = ""
    var isPssword: Bool = false
    var keyboardType: UIKeyboardType = .default

    @Binding var text: String
    @State private var showPassword: Bool = false
    @FocusState var focusedField: String?
    
    var body: some View {
        HStack(spacing: 16) {
            if (icon != "") {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                if !title.isEmpty {
                    Text(title)
                        .font(.jfFont(size: 18))
                        .foregroundColor(AppColors.greyDark)
                }
                
                if isPssword {
                    if showPassword {
                        TextField(placeHolder, text: $text)
                            .font(.jfFont(size: 18))
                            .padding(.top, title == "" ? 0 : 8)
                            
                    } else {
                        SecureField(placeHolder, text: $text)
                            .font(.jfFont(size: 18))
                            .padding(.top, title == "" ? 0 : 8)
                    }
                } else {
                    TextField(placeHolder, text: $text)
                        .font(.jfFont(size: 18))
                        .padding(.top, title == "" ? 0 : 8)
                        .keyboardType(keyboardType)
                        .id(placeHolder)
                        .focused($focusedField, equals: placeHolder)
                }
            }
            
            if (isPssword) {
                Button {
                    showPassword.toggle()
                    
                } label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 18)
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
//        .shadow(color: .gray, radius: 2)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}
