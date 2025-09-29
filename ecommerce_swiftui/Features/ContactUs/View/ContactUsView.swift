//
//  ContactUsView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

struct ContactUsView: View {
    @StateObject private var viewModel = ContactsViewModel()
    @Environment(Router.self) var router

    @FocusState private var focusedField: String?
    
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Image(AppAssets.appLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        TitleValueView(
                            title: "Phone".tr(),
                            value: $viewModel.settings.t.orEmpty()
                        )
      
                        TitleValueView(
                            title: "Email".tr(),
                            value: $viewModel.settings.email.orEmpty()
                        )
                        
                        TitleValueView(
                            title: "Address".tr(),
                            value: $viewModel.settings.address.orEmpty()
                        )
                        
                        TitleValueView(
                            title: "website".tr(),
                            value: $viewModel.settings.website.orEmpty()
                        )
                    }
                    .padding()
                    
                    HStack {
                        SocialMediaItemView(
                            icon: AppAssets.whatsapp,
                            link: viewModel.social.first?.phone ?? "",
                            openWhatsapp: true
                        )
                        
                        SocialMediaItemView(
                            icon: AppAssets.facebook,
                            link: viewModel.social.first?.facebook ?? ""
                        )
                        
                        SocialMediaItemView(
                            icon: AppAssets.instagram,
                            link: viewModel.social.first?.instagram ?? ""
                        )
                    }
             
                    VStack {
                        IconTextField(
                            placeHolder: "Name".tr(),
                            icon: AppAssets.user,
                            keyboardType: .namePhonePad,
                            text: $viewModel.nameTF,
                            focusedField: _focusedField
                        )
                        .padding(.bottom, 8)
                        
                        IconTextField(
                            placeHolder: "Email".tr(),
                            icon: AppAssets.mail,
                            keyboardType: .emailAddress,
                            text: $viewModel.mailTF,
                            focusedField: _focusedField
                        )
                        .padding(.bottom, 8)
                        
                        IconTextField(
                            placeHolder: "Phone".tr(),
                            icon: AppAssets.phone,
                            keyboardType: .asciiCapableNumberPad,
                            text: $viewModel.phoneTF,
                            focusedField: _focusedField
                        )
                        .padding(.bottom, 8)
                        
                        IconTextField(
                            placeHolder: "msgTitle".tr(),
                            icon: "",
                            text: $viewModel.titleTF,
                            focusedField: _focusedField
                        )
                        .padding(.bottom, 8)
                        
                        TextEditor(text: $viewModel.messageTF)
                            .font(.jfFont(size: 18))
                            .padding(12)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
                            .padding(.horizontal, 16)

                        ColoredButton(
                            title: "send".tr(),
                            showArrow: false, isGrediant: true
                        ) {
                            viewModel.sendMessage()
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                viewModel.getContacts()
            }
            .onChange(of: viewModel.navigateToHome, { oldValue, newValue in
                if newValue {
                    router.pop()
                }
            })
            .customNavigation(title: "contactUs".tr(), showBackBtn: true)
            .toastView(toast: $viewModel.toast)
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}

#Preview {
    ContactUsView()
}
