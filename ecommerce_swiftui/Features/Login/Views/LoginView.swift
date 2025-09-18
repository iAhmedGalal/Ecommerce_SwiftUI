//
//  LoginView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 16/09/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            VStack {
                Image(AppAssets.nameApp)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding()
                
                IconTextField(
                    title: "Email Or Phone",
                    placeHolder: "Email",
                    icon: AppAssets.mail,
                    text: $viewModel.mailTF
                )
                .padding(.bottom, 8)
                
                IconTextField(
                    title: "Password",
                    placeHolder: "Passwors",
                    icon: AppAssets.iconLock,
                    isPssword: true,
                    text: $viewModel.passwordTF
                )
                
                HStack {
                    CheckBoxView()
                        .padding(.vertical, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 4)
                    
                    Text("Remember Me?")
                        .font(.jfFont(size: 18))

                    Spacer()
                }
                
                if viewModel.isLoading {
                    // add linear loading indicator
                }
                else {
                    ColoredButton(
                        title: "Login",
                        showArrow: true,
                        isGrediant: true
                    ) {
                        viewModel.login()
                    }
                }
                
                ColoredButton(
                    title: "Creat Account",
                    showArrow: false,
                    bgColor: AppColors.darkGrey
                ) {
                    
                }
                .padding(.top, -20)
                
                Button {
                    
                } label: {
                    HStack(spacing: 4) {
                        Text("Forget Password")
                            .font(.jfFont(size: 18))
                            .foregroundColor(AppColors.red)
                        
                        Image(systemName: "exclamationmark.circle")
                            .foregroundStyle(.colorRedFav)
                    }
                }
            }
            .toastView(toast: $viewModel.toast)
            
            if viewModel.isLoading {
                Color.black.opacity(0.3).ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.white)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    LoginView()
}
