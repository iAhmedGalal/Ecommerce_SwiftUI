//
//  ForgetPasswordView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 29/09/2025.
//

import SwiftUI

struct ForgetPasswordView: View {
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
                    
                    Text("sendResetPasswordMail".tr())
                        .font(.jfFont(size: 18))
                        .padding()
                    
                    IconTextField(
                        title: "Email".tr(),
                        placeHolder: "Email".tr(),
                        icon: AppAssets.mail,
                        keyboardType: .emailAddress,
                        text: $viewModel.mailTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    
                    ColoredButton(title: "send".tr(), showArrow: false, isGrediant: true) {
//                        viewModel.sendResetCode()
                        router.push(.resetPassword(viewModel.mailTF))

                    }
                }
            }
            .toastView(toast: $viewModel.toast)
            .customNavigation(title: "Forget Password".tr(), showBackBtn: true)
            .onChange(of: viewModel.navigateToResetPassword) { oldValue, newValue in
                if (newValue) {
                    router.push(.resetPassword(viewModel.mailTF))
                    viewModel.navigateToResetPassword = false
                }
            }
        }
    }
}

#Preview {
    ForgetPasswordView()
}
