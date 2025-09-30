//
//  DeleteAccountView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 29/09/2025.
//

import SwiftUI

struct DeleteAccountView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    @Binding var showDeleteAccount: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Text("deleteAccountDoYouWant".tr())
                .font(.jfFontBold(size: 18))
            
            Text("deleteAccountMakeSure".tr())
                .font(.jfFont(size: 16))
            
           
            HStack {
                Button("back".tr()) {
                    showDeleteAccount = false
                }
                .font(.jfFontBold(size: 16))
                .frame(maxWidth: .infinity)
                
                Button("confirm".tr()) {
                    viewModel.deleteAccount()
                }
                .font(.jfFontBold(size: 16))
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 8)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .padding(8)
    }
}
