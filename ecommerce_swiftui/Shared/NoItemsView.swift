//
//  NoItemsView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 23/09/2025.
//

import SwiftUI

struct NoItemsView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(AppAssets.box)
                .resizable()
                .scaledToFit()
                .frame(height: 128)
            
            Text("noData".tr())
                .font(.jfFontBold(size: 20))
                .foregroundStyle(.colorGrayDark)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    NoItemsView()
}
