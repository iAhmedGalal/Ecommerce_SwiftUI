//
//  ResetPasswordView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 29/09/2025.
//

import SwiftUI

struct ResetPasswordView: View {
    @State var email: String
    @StateObject private var viewModel = ForgetPasswordViewModel()
    @Environment(Router.self) var router
    @FocusState private var focusedField: String?

    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                VStack() {
                    Image(AppAssets.nameApp)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170)
                        .padding()
                    
                    Text("enterCode".tr())
                        .font(.jfFont(size: 18))
                        .padding()
                    
                    IconTextField(
                        title: "labelCode".tr(),
                        placeHolder: "labelCode".tr(),
                        icon: AppAssets.key,
                        text: $viewModel.codeTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "newPassword".tr(),
                        placeHolder: "newPassword".tr(),
                        icon: AppAssets.iconLock,
                        isPssword: true,
                        text: $viewModel.newPasswordTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "confirmNewPassword".tr(),
                        placeHolder: "confirmNewPassword".tr(),
                        icon: AppAssets.iconLock,
                        isPssword: true,
                        text: $viewModel.confirmNewPasswordTF,
                        focusedField: _focusedField
                    )
                    
                    ColoredButton(
                        title: "save".tr(),
                        showArrow: false,
                        isGrediant: true
                    ) {
                        viewModel.resetPassword()
                    }
                }
            }
            .toastView(toast: $viewModel.toast)
            .customNavigation(title: "resetPassword".tr(), showBackBtn: true)
            .onChange(of: viewModel.navigateToLogin) { oldValue, newValue in
                if (newValue) {
                    router.push(.login)
                    viewModel.navigateToLogin = false
                }
            }
        }
    }
}

#Preview {
    ResetPasswordView(email: "")
}
