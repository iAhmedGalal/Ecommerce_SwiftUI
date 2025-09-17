//
//  CategoriesModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

struct CategoriesModel: Codable, Identifiable {
    var id : Int?
    var name : String?
    var image : String?
    var show_items : Int?
    var selectedState: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", image = "image"
        case show_items = "show_items"
    }
}
