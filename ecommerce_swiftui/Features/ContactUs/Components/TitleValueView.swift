//
//  TitleValueView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 29/09/2025.
//

import SwiftUI

struct TitleValueView: View {
    var title: String
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(title + ":")
                .font(.jfFontBold(size: 16))
            
            Text(value)
                .font(.jfFont(size: 16))
            
            Spacer()
        }
    }
}
