//
//  MenuView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 21/09/2025.
//

import SwiftUI

struct MenuView: View {    
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                MenuItemView(
                    title: "login".tr(),
                    image: AppAssets.menuLogin,
                    page: .login
                )
                .padding(.top, 8)
                
                MenuItemView(
                    title: "createAccount".tr(),
                    image: AppAssets.user,
                    page: .register
                )
                
                MenuItemView(
                    title: "profile".tr(),
                    image: AppAssets.menuProfile,
                    page: .profile
                )
                
                MenuItemView(
                    title: "companies".tr(),
                    image: AppAssets.menuOffers,
                    page: .companies
                )
                
                MenuItemView(
                    title: "discounts".tr(),
                    image: AppAssets.menuOffers,
                    page: .dicounts
                )
                
                MenuItemView(
                    title: "favourites".tr(),
                    image: AppAssets.menuFav,
                    page: .favourites
                )
                
                MenuItemView(
                    title: "aboutUs".tr(),
                    image: AppAssets.menuAbout,
                    page: .aboutUs
                )
                
                MenuItemView(
                    title: "Terms and Conditions".tr(),
                    image: AppAssets.menuTerms,
                    page: .terms
                )
                
                MenuItemView(
                    title: "contactUs".tr(),
                    image: AppAssets.menuCall,
                    page: .contactUs
                )
                
                MenuItemView(
                    title: "logout".tr(),
                    image: AppAssets.menuLogout,
                    page: .login,
                    isLogout: true
                )
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    MenuView()
}

