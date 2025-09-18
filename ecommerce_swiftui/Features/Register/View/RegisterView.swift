//
//  RegisterView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 17/09/2025.
//

import SwiftUI

struct RegisterView: View {    
    @StateObject private var viewModel = RegisterViewModel()

    var body: some View {

        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Image(AppAssets.nameApp)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170)
                        .padding()
                    
                    IconTextField(
                        title: "Name",
                        placeHolder: "Name",
                        icon: AppAssets.user,
                        keyboardType: .namePhonePad,
                        text: .constant(""),
                        focusedField: viewModel.$focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Email",
                        placeHolder: "Email",
                        icon: AppAssets.mail,
                        keyboardType: .emailAddress,
                        text: .constant(""),
                        focusedField: $viewModel.focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Phone",
                        placeHolder: "Phone",
                        icon: AppAssets.phone,
                        keyboardType: .asciiCapableNumberPad,
                        text: .constant(""),
                        focusedField: $viewModel.focusedField
                    )
                    .padding(.bottom, 8)
                    

                    ZStack(alignment: .trailing) {
                        IconTextField(
                            title: "Address",
                            placeHolder: "Address",
                            icon: AppAssets.map,
                            text: .constant(""),
                            focusedField: viewModel.focusedField
                        )
                        
                        Button {
                            
                        } label: {
                            Image(AppAssets.markerDown)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                                .padding(.horizontal, 28)
                        }
                    }
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Password",
                        placeHolder: "Passwors",
                        icon: AppAssets.iconLock,
                        isPssword: true,
                        text: .constant(""),
                        focusedField: viewModel.focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Confirm Password",
                        placeHolder: "Passwors",
                        icon: AppAssets.iconLock,
                        isPssword: true,
                        text: .constant(""),
                        focusedField: viewModel.focusedField
                    )
                    
                    HStack(spacing: 4) {
                        CheckBoxView()
                            .padding(.vertical, 16)
                            .padding(.leading, 16)
                            .padding(.trailing, 4)
                        
                        Text("Accept All")
                            .font(.jfFont(size: 18))
                        
                        Button {
                            
                        } label: {
                            Text("Terms and Conditions")
                                .font(.jfFont(size: 18))
                                .underline()
                        }
                        
                        Spacer()
                    }
                    
                    ColoredButton(title: "Creat Account", showArrow: false, isGrediant: true) {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
