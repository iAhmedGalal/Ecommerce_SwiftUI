//
//  CartModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 01/10/2025.
//

import SwiftUI

struct CartModel: Identifiable, Equatable, Codable {
    var id: Int?
    var cartId: String?
    var name: String?
    var image: String?
    var notes: String?
    var vatState: Int?
    var selectedUnit: Int?
    var selectedQuantity: Int?
    var offerId : Int?
    var hasOffer : Int?
    var isMainItem : Bool = false
    var colorId : Int?
    var sizeId : Int?
    var unitId : Int?
    var unitName : String?
    var quantity : Int?
    var maxQuantity : Int?
    var salePrice : String?
    var newPrice : String?
    var basicPrice : String?
    var discount : String?
    var hasDiscount : Int?
    var discountType : Int?
    var remainDiscountQuantity : Int?
}

