//
//  RegisterView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 17/09/2025.
//

import SwiftUI

struct RegisterView: View {
    @Environment(Router.self) var router

    @StateObject private var viewModel = RegisterViewModel()
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
                    

                    ZStack(alignment: .trailing) {
                        IconTextField(
                            title: "Address".tr(),
                            placeHolder: "Address".tr(),
                            icon: AppAssets.map,
                            text: $viewModel.addressTF,
                            focusedField: _focusedField
                        )
                        
                        Button {
                            viewModel.showMap = true
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
                        title: "Password".tr(),
                        placeHolder: "Password".tr(),
                        icon: AppAssets.iconLock,
                        isPssword: true,
                        text: $viewModel.passwordTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Confirm Password".tr(),
                        placeHolder: "Confirm Password".tr(),
                        icon: AppAssets.iconLock,
                        isPssword: true,
                        text: $viewModel.confirmPasswordTF,
                        focusedField: _focusedField
                    )
                    
                    HStack(spacing: 4) {
                        CheckBoxView(isChecked: $viewModel.acceptTerms)
                            .padding(.vertical, 16)
                            .padding(.leading, 16)
                            .padding(.trailing, 4)
                        
                        Text("Accept All".tr())
                            .font(.jfFont(size: 18))
                        
                        Button {
                            
                        } label: {
                            Text("Terms and Conditions".tr())
                                .font(.jfFont(size: 18))
                                .underline()
                        }
                        
                        Spacer()
                    }
                    
                    ColoredButton(title: "createAccount".tr(), showArrow: false, isGrediant: true) {
                        viewModel.register()
                    }
                }
            }
            .toastView(toast: $viewModel.toast)
            .customNavigation(title: "createAccount".tr(), router: router, showBackBtn: true)
            .onChange(of: viewModel.navigateToLogin) { oldValue, newValue in
                if (newValue) {
                    router.push(.login)
                    viewModel.navigateToLogin = false
                }
            }
//            .sheet(isPresented: $viewModel.showMap) {
//                LocationDialogView(
//                    selectedCoordinate: $viewModel.selectedCoordinate,
//                    selectedAddress: $viewModel.addressTF,
//                    isPresented: $viewModel.showMap
//                )
//                .presentationDetents([.height(525)])
//            }
            
            if viewModel.showMap {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.showMap = false
                    }
                
                LocationDialogView(
                    selectedCoordinate: $viewModel.selectedCoordinate,
                    selectedAddress: $viewModel.addressTF,
                    isPresented: $viewModel.showMap
                )
                .frame(maxWidth: .infinity)
                .frame(height: 525)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .padding()
                .transition(.scale)
            }
        }
    }
}

#Preview {
    RegisterView()
}
