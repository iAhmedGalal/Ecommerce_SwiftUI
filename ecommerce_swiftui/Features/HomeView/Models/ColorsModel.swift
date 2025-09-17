//
//  ColorsModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import Foundation

struct ColorsModel: Identifiable, Codable {
    var id: Int?
    var colorName: String?
    var colorCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case colorName = "color_name"
        case colorCode = "color_code"
    }
}
