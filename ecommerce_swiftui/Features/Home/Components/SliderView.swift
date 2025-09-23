//
//  SliderView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI

struct SliderView: View {
    var sliderList: [SliderModel]
    
    let images = ["https://kenzgomla.com/badrshop/upload/1755353285-68a090c5a44e4.png",
                  "https://kenzgomla.com/badrshop/upload/1755347590-68a07a860346d.jpg",
                  "https://kenzgomla.com/badrshop/upload/1755347335-68a07987b4777.jpg"]
    
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect() // كل 3 ثواني
    
    var body: some View {
        if images.isEmpty {
            Image(AppAssets.appLogo)
                .resizable()
                .frame(height: 250)
                .scaledToFit()
                .cornerRadius(8)
                .shadow(radius: 0.3)
                .padding(8)
        }
        else {
            ZStack(alignment: .bottom) {
                TabView(selection: $currentIndex) {
                    ForEach(0..<images.count, id: \.self) { index in
                        CachedAsyncImageView(url: images[index])
                            .tag(index)
                            .clipped()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 250)
                .background(Color(AppColors.greyWhite))
                .cornerRadius(8)
                .shadow(radius: 0.3)
                .padding(8)
                .onReceive(timer) { _ in
                    withAnimation {
                        currentIndex = (currentIndex + 1) % images.count
                    }
                }
                
                HStack(spacing: 8) {
                    ForEach(0..<images.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex ? Color(AppColors.darkPrimary) : Color.gray) // لون مخصص
                            .frame(width: 10, height: 10)
                            .animation(.easeInOut, value: currentIndex)
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}
