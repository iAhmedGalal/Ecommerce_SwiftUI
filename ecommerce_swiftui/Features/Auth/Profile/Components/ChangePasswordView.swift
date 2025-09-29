//
//  ChangePasswordView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 29/09/2025.
//

import SwiftUI

struct ChangePasswordView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @FocusState private var focusedField: String?

    @Binding var showChangePassword: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Text("editPassword".tr())
                .font(.jfFontBold(size: 18))
                .padding(.vertical, 16)
            
            IconTextField(
                title: "currentPassword".tr(),
                placeHolder: "currentPassword".tr(),
                icon: AppAssets.iconLock,
                isPssword: true,
                text: $viewModel.passwordTF,
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
                title: "edit".tr(),
                showArrow: false,
                isGrediant: true
            ) {
                viewModel.editProfile()
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .padding()
    }
}
