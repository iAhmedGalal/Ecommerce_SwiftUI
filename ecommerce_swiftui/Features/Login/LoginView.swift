//
//  LoginView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 16/09/2025.
//

import SwiftUI

struct LoginView: View {
 
    
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
                    title: "Email Or Phone",
                    placeHolder: "Email",
                    icon: AppAssets.mail
                )
                
                IconTextField(
                    title: "Password",
                    placeHolder: "Passwors",
                    icon: AppAssets.iconLock,
                    isPssword: true
                )
                
                CheckBoxView()
                
                ColoredButton(title: "Login", showArrow: true) {
                    
                }
                
                ColoredButton(title: "Creat Account", showArrow: false) {
                    
                }
                
                
                
                Button {
                    
                } label: {
                    HStack(spacing: 4) {
                        Text("Forget Password")
                            .font(.jfFont(size: 18))
                            .foregroundColor(AppColors.red)
                        
                        Image(systemName: "exclamationmark.circle")
                            .foregroundStyle(.colorRedFav)
                    }
                }

            }
        }
    }
}

struct ColoredButton: View {
    @State var title: String
    @State var showArrow: Bool = false
    @State var onTap: (() -> Void)
    
    var body: some View {
        Button {
            onTap()
        } label: {
            ZStack(alignment: .trailing) {
                Text(title)
                    .font(.jfFont(size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity) // ياخد العرض كله
                    .padding()
                    .background(Color(AppColors.darkPrimary))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(16)
                
                
                if showArrow {
                    Image(AppAssets.arrowRight)
                        .resizable()
                        .frame(width: 14, height: 25)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding(.horizontal, 28)
                }
            }
        }
    }
}

struct IconTextField: View {
    @State var title: String = ""
    @State var placeHolder: String = ""
    @State var text: String = ""
    @State var icon: String = ""
    @State var isPssword: Bool = false

    var body: some View {
        HStack(spacing: 16) {
            if (icon != "") {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                if (title != "") {
                    Text(title)
                        .font(.jfFont(size: 18))
                        .foregroundColor(AppColors.greyDark)
                }
                
                if isPssword {
                    SecureField(placeHolder, text: $text)
                        .padding(.top, 8)
                }
                else {
                    TextField(placeHolder, text: $text)
                        .padding(.top, 8)
                }
            }
            
            if (isPssword) {

                Button {
                    
                } label: {
                    Image(systemName: "eye.slash") // eye
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(.colorGrayDark)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .gray, radius: 2)
        .padding(.horizontal, 16)
    }
}

struct CheckBoxView: View {
    @State private var isChecked: Bool = false
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Button(action: {
                isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark" : "checkmark")
                    .foregroundColor(isChecked ? .dark : .white)
                    .font(.system(size: 20))
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .gray, radius: 2)
            }
            
            Text("Remember Me?")
                .font(.jfFont(size: 18))
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
