//
//  SplashView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 16/09/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0.3
    
    private var currentYear: String {
        let year = Calendar.current.component(.year, from: Date())
        return String(year)
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Image(AppAssets.splashBackground)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Image(AppAssets.nameAppWhite)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 256)
                        .padding(.vertical, 48)
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.5)) {
                                self.scale = 1.0
                                self.opacity = 1.0
                            }
                        }
                    
                    Spacer()
                    
                    Text("Copyright © \(currentYear) All Rights Reserved")
                        .font(.jfFont(size: 18))
                        .foregroundColor(.white)
                }
                .animation(.easeInOut(duration: 0.8), value: isActive)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.isActive = true
                    }
                }
            }
            .navigationDestination(isPresented: $isActive) {
                let token = SessionManager.shared.currentUser?.token ?? ""
                
                if token.isEmpty {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                } else {
                    HomeNavView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
