//
//  LoginView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 16/09/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Environment(Router.self) var router
    @EnvironmentObject var localizationManager: LocalizationManager

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
                    title: "Email Or Phone".tr(),
                    placeHolder: "Email".tr(),
                    icon: AppAssets.mail,
                    text: $viewModel.mailTF
                )
                .padding(.bottom, 8)
                
                IconTextField(
                    title: "Password".tr(),
                    placeHolder: "Password".tr(),
                    icon: AppAssets.iconLock,
                    isPssword: true,
                    text: $viewModel.passwordTF
                )
                
                HStack {
                    CheckBoxView(isChecked: $viewModel.rememberMe)
                        .padding(.vertical, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 4)
                    
                    Text("Remember Me?".tr())
                        .font(.jfFont(size: 18))
                    
                    Spacer()
                }
                
                if viewModel.isLoading {
                    // add linear loading indicator
                }
                else {
                    ColoredButton(
                        title: "login".tr(),
                        showArrow: true,
                        isGrediant: true
                    ) {

                        viewModel.login()
                    }
                }
                
                ColoredButton(
                    title: "createAccount".tr(),
                    showArrow: false,
                    bgColor: AppColors.darkGrey
                ) {
                    router.push(.register)
                }
                .padding(.top, -20)
                
                Button {
                    
                } label: {
                    HStack(spacing: 4) {
                        Text("Forget Password".tr())
                            .font(.jfFont(size: 18))
                            .foregroundColor(AppColors.red)
                        
                        Image(systemName: "exclamationmark.circle")
                            .foregroundStyle(.colorRedFav)
                    }
                }
                
                Spacer()
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
        .customNavigation(title: "login".tr(), showBackBtn: false)
        .onAppear {
            viewModel.getUserCredentials()
        }
        .onChange(of: viewModel.navigateToHome) { oldValue, newValue in
            if newValue {
                router.push(.main)
                viewModel.navigateToHome = false
            }
        }
    }
}

#Preview {
    LoginView()
}
