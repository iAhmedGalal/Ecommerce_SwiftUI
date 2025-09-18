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
                
                    Spacer()
                }
                
                ColoredButton(title: "Login", showArrow: true) {
                    viewModel.login()
                }
                
                ColoredButton(title: "Creat Account", showArrow: false) {
                    
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

struct ColoredButton: View {
    var title: String
    var showArrow: Bool = false
    var onTap: (() -> Void)
    
    var body: some View {
        Button {
            onTap()
        } label: {
            ZStack(alignment: .trailing) {
                Text(title)
                    .font(.jfFont(size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity) // ياخد العرض كله
                    .padding()
                    .background(Color(AppColors.darkPrimary))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(16)
                
                
                if showArrow {
                    Image(AppAssets.arrowRight)
                        .resizable()
                        .frame(width: 14, height: 25)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding(.horizontal, 28)
                }
            }
        }
    }
}

struct IconTextField: View {
    var title: String = ""
    var placeHolder: String = ""
    var icon: String = ""
    var isPssword: Bool = false

    @Binding var text: String

    @State private var showPassword: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            if (icon != "") {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                if (title != "") {
                    Text(title)
                        .font(.jfFont(size: 18))
                        .foregroundColor(AppColors.greyDark)
                }
                
                if isPssword {
                    if showPassword {
                        TextField(placeHolder, text: $text)
                            .padding(.top, 8)
                    } else {
                        SecureField(placeHolder, text: $text)
                            .padding(.top, 8)
                    }
                } else {
                    TextField(placeHolder, text: $text)
                        .padding(.top, 8)
                }
            }
            
            if (isPssword) {
                Button {
                    showPassword.toggle()
                    
                } label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(.colorGrayDark)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .gray, radius: 2)
        .padding(.horizontal, 16)
    }
}

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
                    .shadow(color: .gray, radius: 2)
            }
            
            Text("Remember Me?")
                .font(.jfFont(size: 18))
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
