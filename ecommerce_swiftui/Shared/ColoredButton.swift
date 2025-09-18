//
//  ColoredButton.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 18/09/2025.
//

import SwiftUI

struct ColoredButton: View {
    var title: String
    var showArrow: Bool = false
    var isGrediant: Bool = false
    var bgColor: Color = AppColors.darkPrimary
    var onTap: (() -> Void)

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
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    ) }
                    .if(!isGrediant) { $0.background(
                        Color(bgColor)
                    ) }
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(color: bgColor.opacity(0.25), radius: 4, x: 0, y: 1)
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
