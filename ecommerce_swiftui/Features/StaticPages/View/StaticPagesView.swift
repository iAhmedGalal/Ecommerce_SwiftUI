//
//  StaticPagesView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI

struct StaticPagesView: View {
    @StateObject private var viewModel = StaticPagesViewModel()
    
    var pageType: StaticPageType
    
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
                    
                    Text(pageType == .about
                         ? viewModel.aboutText
                         : viewModel.termsText)
                    .font(.jfFont(size: 18))
                    .padding(8)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .padding(.vertical)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
                .padding(8)
            }
        }
        .customNavigation(
            title: pageType == .about
                    ? "aboutUs".tr()
                    : "Terms and Conditions".tr(),
            showBackBtn: true
        )
        .onAppear {
            switch pageType {
            case .about:
                viewModel.getAbout()
            case .terms:
                viewModel.getTerms()
            }
        }
    }
}

#Preview {
    StaticPagesView(pageType: .about)
}
