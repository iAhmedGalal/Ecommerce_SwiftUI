//
//  ContactsModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 28/09/2025.
//

struct ContactsModel: Codable {
    var settings: ContactsSettingsModel?
    var social: [ContactsSocialModel]?

    enum CodingKeys: String, CodingKey {
        case settings = "settings", social = "social"
    }
}

struct ContactsSettingsModel: Codable {
    var shop_name: String?
    var telephone: String?
    var address: String?
    var website: String?
    var email: String?
    var t: String?

    enum CodingKeys: String, CodingKey {
        case shop_name = "shop_name", telephone = "telephone"
        case address = "address", website = "website"
        case email = "email", t = "t"
    }
}

struct ContactsSocialModel: Codable {
    var id : Int?
    var instagram : String?
    var phone : String?
    var google : String?
    var landNumber : String?
    var shop_id : Int?
    var complaintsNumber : String?
    var snap_chat : String?
    var twitter : String?
    var youtube : String?
    var facebook : String?

    enum CodingKeys: String, CodingKey {
        case id = "id", instagram = "instagram"
        case phone = "phone", google = "google"
        case landNumber = "landNumber", shop_id = "shop_id"
        case complaintsNumber = "complaintsNumber", snap_chat = "snap_chat"
        case twitter = "twitter", youtube = "youtube"
        case facebook = "facebook"
    }
}
