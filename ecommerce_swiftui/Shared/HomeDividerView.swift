//
//  HomeDividerView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 15/09/2025.
//

import SwiftUI

struct HomeDividerView: View {
    @Environment(Router.self) var router

    var title: String
    var showMore: Bool
    var route: AppRoutes?

    var body: some View {
        ZStack(alignment: .trailing) {
            if (showMore) {
                Button {
                    router.push(route!)
                } label: {
                    Text("More >>")
                        .font(.jfFont(size: 18))
                        .padding(16)
                }
                .background(Color(AppColors.white))
                .foregroundColor(.black)
                .cornerRadius(24)
                .shadow(radius: 0.3)
            }
            
            HStack {
                Spacer()

                Text(title)
                    .font(.jfFont(size: 20))
                    .padding(16)
                    .background(Color(AppColors.darkPrimary))
                    .foregroundColor(.white)
                    .cornerRadius(24)
                
                Spacer()
            }
        }
        .padding(8)
    }
}
