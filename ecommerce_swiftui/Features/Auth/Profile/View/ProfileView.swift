//
//  ProfileView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

struct ProfileView: View {
    @Environment(Router.self) var router

    @StateObject private var viewModel = ProfileViewModel()
    @FocusState private var focusedField: String?
 
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
                        title: "Name".tr(),
                        placeHolder: "Name".tr(),
                        icon: AppAssets.user,
                        keyboardType: .namePhonePad,
                        text: $viewModel.nameTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Email".tr(),
                        placeHolder: "Email".tr(),
                        icon: AppAssets.mail,
                        keyboardType: .emailAddress,
                        text: $viewModel.mailTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Phone".tr(),
                        placeHolder: "Phone".tr(),
                        icon: AppAssets.phone,
                        keyboardType: .asciiCapableNumberPad,
                        text: $viewModel.phoneTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    
                    HStack(spacing: 0) {
                        ColoredButton(
                            title: "edit".tr(),
                            showArrow: false,
                            isGrediant: true
                        ) {
                            viewModel.editProfile()
                        }
                        .frame(maxWidth: .infinity)
                        
                        ColoredButton(
                            title: "editPassword".tr(),
                            showArrow: false,
                            isGrediant: false,
                            bgColor: AppColors.red
                        ) {
                            viewModel.showEditPassword = true
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    ColoredButton(title: "deleteAccount".tr(), showArrow: false, isGrediant: false, bgColor: AppColors.black) {
                        viewModel.showDeleteWarning = true
                    }
                    .padding(.top, -20)
                }
            }
            .toastView(toast: $viewModel.toast)
            .customNavigation(title: "profile".tr(), showBackBtn: true)
            .onAppear {
                viewModel.showUserData()
            }
            .onChange(of: viewModel.navigateToLogin) { oldValue, newValue in
                if (newValue) {
                    router.push(.login)
                    viewModel.navigateToLogin = false
                }
            }
            .onChange(of: viewModel.navigateToHome) { oldValue, newValue in
                if (newValue) {
                    router.push(.main)
                    viewModel.navigateToHome = false
                }
            }
            
            if viewModel.showEditPassword {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.showEditPassword = false
                    }
                
                ChangePasswordView(
                    showChangePassword: $viewModel.showEditPassword
                )
            }
            
            if viewModel.showDeleteWarning {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.showDeleteWarning = false
                    }
                
                DeleteAccountView(
                    showDeleteAccount: $viewModel.showDeleteWarning
                )
            }
        }
    }
}

#Preview {
    ProfileView()
}
