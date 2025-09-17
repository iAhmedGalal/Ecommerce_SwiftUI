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
                    icon: AppAssets.mail,
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
                
                HStack {
                    CheckBoxView()
                        .padding(.vertical, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 8)
                    
                    Text("Remember Me?")
                        .font(.jfFont(size: 18))
                    
                    Spacer()
                }
                
                ColoredButton(title: "Login", showArrow: true, isGrediant: true) {
                    
                }
                
                ColoredButton(title: "Creat Account", showArrow: false, bgColor: AppColors.darkGrey) {
                    
                }
                .padding(.top, -20)
                
                
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
    @State var isGrediant: Bool = false
    @State var bgColor: Color = AppColors.darkPrimary
    @State var onTap: (() -> Void)
    
    private let gradientColors = [Color(AppColors.gradientColor1), Color(AppColors.gradientColor2)]

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
                    .if(isGrediant) { $0.background(
                        LinearGradient(
                            gradient: Gradient(colors: gradientColors),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    ) }
                    .if(!isGrediant) { $0.background(
                        Color(bgColor)
                    ) }
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
    var title: String = ""
    var placeHolder: String = ""
    var icon: String = ""
    var isPssword: Bool = false

    @Binding var text: String
    @State private var showPassword: Bool = false

    var body: some View {
        HStack(spacing: 16) {
            if (icon != "") {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                if !title.isEmpty {
                    Text(title)
                        .font(.jfFont(size: 18))
                        .foregroundColor(AppColors.greyDark)
                }
                
                if isPssword {
                    if showPassword {
                        TextField(placeHolder, text: $text)
                            .padding(.top, 8)
                    } else {
                        SecureField(placeHolder, text: $text)
                            .padding(.top, 8)
                    }
                } else {
                    TextField(placeHolder, text: $text)
                        .padding(.top, 8)
                }
            }
            
            if isPssword {
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 18)
                        .foregroundStyle(.gray)
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
        HStack() {
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
        }
    }
}

#Preview {
    LoginView()
}
