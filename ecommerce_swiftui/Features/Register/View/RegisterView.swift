//
//  RegisterView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 17/09/2025.
//

import SwiftUI

struct RegisterView: View {
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
                    title: "Name",
                    placeHolder: "Name",
                    icon: AppAssets.user,
                    text: .constant("")
                )
                .padding(.bottom, 8)
                
                IconTextField(
                    title: "Email",
                    placeHolder: "Email",
                    icon: AppAssets.mail,
                    text: .constant("")
                )
                .padding(.bottom, 8)
                
                IconTextField(
                    title: "Phone",
                    placeHolder: "Phone",
                    icon: AppAssets.phone,
                    text: .constant("")
                )
                .padding(.bottom, 8)
                
                IconTextField(
                    title: "Password",
                    placeHolder: "Passwors",
                    icon: AppAssets.iconLock,
                    isPssword: true,
                    text: .constant("")
                )
                .padding(.bottom, 8)
                
                IconTextField(
                    title: "Confirm Password",
                    placeHolder: "Passwors",
                    icon: AppAssets.iconLock,
                    isPssword: true,
                    text: .constant("")
                )
                
                HStack(spacing: 4) {
                    CheckBoxView()
                        .padding(.vertical, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 8)
                    
                    Text("Accept All")
                        .font(.jfFont(size: 18))
                    
                    Button {
                        
                    } label: {
                        Text("Terms and Conditions")
                            .font(.jfFont(size: 18))
                            .underline()
                    }
                    
                    Spacer()
                }
                
                ColoredButton(title: "Creat Account", showArrow: false, isGrediant: true) {
                    
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
