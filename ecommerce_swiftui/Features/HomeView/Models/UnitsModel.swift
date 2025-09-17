//
//  UnitesModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

struct UnitsModel: Decodable {
    @SafeDecode var unit_id : Int?
    @SafeDecode var unit_value : Int?
    @SafeDecode var unit_name : String?
    @SafeDecode var quantity : Int??
    @SafeDecode var final_max_quantity : Int?
    @SafeDecode var sale_price : String?
    @SafeDecode var new_price : String?
    @SafeDecode var basic_price : String?
    @SafeDecode var vat_name : String?
    @SafeDecode var vat : String?
    @SafeDecode var discount : String?
    @SafeDecode var has_discount : Int?
    @SafeDecode var discount_type : Int?
    @SafeDecode var remain_discount_quantity : Int?
    
    enum CodingKeys: String, CodingKey {
        case unit_id = "unit_id"
        case unit_value = "unit_value"
        case unit_name = "unit_name"
        case quantity = "quantity"
        case final_max_quantity = "final_max_quantity"
        case sale_price = "sale_price"
        case new_price = "new_price"
        case basic_price = "basic_price"
        case vat_name = "vat_name"
        case vat = "vat"
        case discount = "discount"
        case has_discount = "has_discount"
        case discount_type = "discount_type"
        case remain_discount_quantity = "remain_discount_quantity"
    }
}
