//
//  APIResponse.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

struct APIResponse<T: Decodable>: Decodable {
    var status: Bool?
    var message: String?
    var msg: String?
    var maintenance : Int?
    var maintenance_message : String?
    var data: T?
    var items: T?
    var item: T?
    
    enum CodingKeys: String, CodingKey {
        case status = "status", message = "message", msg = "msg"
        case maintenance = "maintenance", maintenance_message = "maintenance_message"
        case data = "data", items = "items", item = "item"
    }
}

struct PaginationResponse<T: Decodable>: Decodable {
    @SafeDecode var total : Int?
    @SafeDecode var current_page : Int?
    @SafeDecode var last_page : Int?
    @SafeDecode var data: [T]?
    var pagination : PaginationModel?

    enum CodingKeys: String, CodingKey {
        case total = "total", current_page = "current_page"
        case last_page = "last_page"
        case pagination = "pagination"
        case data = "data"
    }
}

struct PaginationModel: Decodable {
    @SafeDecode var total : Int?
    @SafeDecode var current_page : Int?
    @SafeDecode var last_page : Int?
    
    enum CodingKeys: String, CodingKey {
        case total = "total", current_page = "current_page"
        case last_page = "last_page"
    }
}

