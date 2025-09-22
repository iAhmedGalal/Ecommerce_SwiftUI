//
//  RegionsModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 23/09/2025.
//

struct RegionsModel: Codable, Identifiable {
    var id: Int?
    var cityName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cityName = "city_name"
    }
}
