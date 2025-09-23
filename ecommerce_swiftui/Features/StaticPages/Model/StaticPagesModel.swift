//
//  StaticPagesModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 23/09/2025.
//

struct StaticPagesModel: Codable {
    var id: Int?
    var title: String?
    var text: String?
    var shopName: String?
    var shopTerms: String?
    var about: String?
      
    enum CodingKeys: String, CodingKey {
        case id = "id", title = "title", text = "text"
        case shopName = "shop_name", shopTerms = "shop_terms"
        case about = "about"
    }
}

enum StaticPageType {
    case about
    case terms
}
