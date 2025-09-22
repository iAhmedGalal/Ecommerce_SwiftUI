//
//  CityMenuView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 23/09/2025.
//

import SwiftUI

struct CityMenuView: View {
    var regionsList: [RegionsModel]
    @Binding var selectedCity: RegionsModel
    
    var body: some View {
        Menu {
            ForEach(regionsList) { city in
                Button {
                    selectedCity = city
                } label: {
                    Text(city.cityName ?? "")
                        .font(.jfFont(size: 18))
                }
            }
        } label: {
            HStack {
                Text(selectedCity.cityName ?? "chooseCity".tr())
                    .font(.jfFont(size: 18))
                    .foregroundColor(.black)
                
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
        }
    }
}
