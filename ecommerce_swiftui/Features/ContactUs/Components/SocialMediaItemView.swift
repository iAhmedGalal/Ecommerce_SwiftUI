//
//  SocialMediaItemView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 29/09/2025.
//

import SwiftUI

struct SocialMediaItemView: View {
    @State var icon: String = ""
    @State var link: String = ""
    @State var openWhatsapp: Bool = false
    
    var body: some View {
        Image(icon)
            .resizable()
            .scaledToFit()
            .frame(width: 30)
            .padding(8)
            .background(.white)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
            .onTapGesture {
                openWhatsapp ? Helper.openWhatsapp(number: link) : Helper.openScheme(scheme: link)
            }
    }
}
