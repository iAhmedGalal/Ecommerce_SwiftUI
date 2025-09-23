//
//  ItemsModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import Foundation

struct ItemsModel: Identifiable, Decodable {
    var id: Int?
    var theId: Int?
    var offerId: Int?
    var hasOffer: Int?
    var isMainItem: Bool = false
    var itemGroup: Int?
    var itemName: String?
    var name: String?
    var salePrice: String?
    var newPrice: String?
    var basicPrice: String?
    var discount: String?
    var discountType: Int?
    var discountVal: Double?
    var vatPercent: Double?
    var vat: String?
    var img: String?
    var unitId: Int?
    var sizeId: Int?
    var colorId: Int?
    var withDiscount: Int?
    var discountPercent: String?
    var quantity: Int?
    var selectedQuantity: Int?
    var maxQuantity: Int?
    var maxQuantityGomla: Int?
    var finalMaxQuantity: Int?
    var selectedUnitId: Int?
    var selectedUnitIndex: Int?
    var cardCompanyId: Int?
    var vatId: Int?
    var vatState: Int?
    var shopId: Int?
    var fav: Bool?
    var unit: String?
    var subCat: String?
    var mainCat: String?
    var size: String?
    var color: String?
    var details: String?
    var rate: Double?
    var avgRate: Double?
    var unitsArr: [UnitsModel]?
    var colors: [ColorsModel]?
    var sizes: [SizesModel]?
    var imgs: [String]?

    var itemId: Int?
    var clientId: Int?
    var clientName: String?
    var itemCategory: String?
    var price: String?
    var total: String?
    var image: String?
    var notes: String?

    var showItemPrice: Int?
    var isGroup: Int?
    var cartId: String?
    var isOrderError: Bool?
    var orderErrorMsg: String?
    var hasDiscount: Int?
    var remainDiscountQuantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, theId = "the_id", offerId = "offer_id", hasOffer = "has_offer"
        case itemGroup = "item_group", itemName = "item_name"
        case name, salePrice = "sale_price", newPrice = "new_price", basicPrice = "basic_price"
        case discount, discountType = "discount_type", discountVal = "discount_val"
        case vatPercent = "vat_percent", vat, img
        case unitId = "unit_id", sizeId = "size_id", colorId = "color_id", withDiscount
        case discountPercent = "discount_percent", quantity, selectedQuantity = "selected_quantity"
        case maxQuantity = "max_quantity", maxQuantityGomla = "max_quantity_gomla"
        case finalMaxQuantity = "final_max_quantity", selectedUnitId = "selected_unit"
        case selectedUnitIndex = "selected_unit_index", cardCompanyId = "card_company_id"
        case vatId = "vat_id", vatState = "vat_state", shopId = "shop_id", fav
        case unit, subCat = "sub_cat", mainCat = "main_cat", size, color, details
        case rate, avgRate = "avg_rate", unitsArr = "new_arr_units", colors, sizes, imgs
        case itemId = "item_id", clientId = "client_id", clientName = "client_name"
        case itemCategory = "item_category", price, total, image, notes
        case showItemPrice = "show_item_price", isGroup, cartId = "cart_id"
        case isOrderError = "is_order_error", orderErrorMsg = "order_error_msg"
        case hasDiscount = "has_discount", remainDiscountQuantity = "remain_discount_quantity"
    }
}

extension ItemsModel: Equatable {
    static func == (lhs: ItemsModel, rhs: ItemsModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
        // مش هنقارن extraData علشان مش Equatable
    }
}
