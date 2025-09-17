//
//  CompaniesModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

struct CompaniesModel: Codable, Identifiable {
    var id : Int?
    var name : String?
    var image : String?
    var selectedState: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", image = "image"
    }
}
