//
//  SizesModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import Foundation

struct SizesModel: Identifiable, Codable {
    var id: Int?
    var sizeName: String?
    var sizeCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case sizeName = "size_name"
        case sizeCode = "size_code"
    }
}
