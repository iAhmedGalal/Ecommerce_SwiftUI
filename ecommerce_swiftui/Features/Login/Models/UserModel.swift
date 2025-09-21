//  Untitled.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 17/09/2025.
//

struct UserModel: Codable {
    var status: Bool?
    var msg: String?
    var token: String?
    var clientId: Int?
    var clientName: String?
    var email: String?
    var phone: String?
    var address: String?
    var lat: String?
    var lon: String?
    var cityId: Int?
    var activeCode: Int?
    var activated: Int?
    var verifiedManager: Int?
    var error: [String]?
    var maintenance: Int?
    var maintenanceMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case msg = "msg"
        case token = "token"
        case clientId = "client_id"
        case clientName = "client_name"
        case email = "email"
        case phone = "phone"
        case activeCode = "active_code"
        case activated = "activated"
        case verifiedManager = "verified_manager"
        case error = "error"
        case maintenance = "maintenance"
        case cityId = "city_id"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case maintenanceMessage = "maintenance_message"
    }
    
    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.status = (try? container.decode(Bool.self, forKey: .status)) ?? false
        
        self.msg = (try? container.decode(String.self, forKey: .msg)) ?? ""
        self.token = (try? container.decode(String.self, forKey: .token)) ?? ""
        self.clientName = (try? container.decode(String.self, forKey: .clientName)) ?? ""
        self.email = (try? container.decode(String.self, forKey: .email)) ?? ""
        self.phone = (try? container.decode(String.self, forKey: .phone)) ?? ""
        self.address = (try? container.decode(String.self, forKey: .address)) ?? ""
        self.lat = (try? container.decode(String.self, forKey: .lat)) ?? ""
        self.lon = (try? container.decode(String.self, forKey: .lon)) ?? ""
        self.activeCode = (try? container.decode(Int.self, forKey: .activeCode)) ?? 0
        self.maintenanceMessage = (try? container.decode(String.self, forKey: .maintenanceMessage)) ?? ""
        
        self.clientId = (try? container.decode(Int.self, forKey: .clientId)) ?? 0
        self.activated = (try? container.decode(Int.self, forKey: .activated)) ?? 0
        self.verifiedManager = (try? container.decode(Int.self, forKey: .verifiedManager)) ?? 0
        self.cityId = (try? container.decode(Int.self, forKey: .cityId)) ?? 0
        self.maintenance = (try? container.decode(Int.self, forKey: .maintenance)) ?? 0
        self.error = (try? container.decode([String].self, forKey: .error)) ?? []

//        self.price = (try? container.decode(String.self, forKey: .price))
//            ?? String((try? container.decode(Int.self, forKey: .price)) ?? 0)
        
//        self.price = (try? container.decode(Int.self, forKey: .price))
//            ?? Int((try? container.decode(String.self, forKey: .price)) ?? 0)
    }
    
    func encode(with coder: Encoder) throws {
        var container = coder.container(keyedBy: CodingKeys.self)

        try container.encode(msg ,forKey: .msg)
        try container.encode(token ,forKey: .token)
        try container.encode(clientId ,forKey: .clientId)
        try container.encode(activeCode ,forKey: .activeCode)
        try container.encode(clientName ,forKey: .clientName)
        try container.encode(phone ,forKey: .phone)
        try container.encode(activated ,forKey: .activated)
        try container.encode(email ,forKey: .email)
        try container.encode(address ,forKey: .address)
        try container.encode(lat ,forKey: .lat)
        try container.encode(lon ,forKey: .lon)
        try container.encode(verifiedManager ,forKey: .verifiedManager)
        try container.encode(cityId ,forKey: .cityId)
        try container.encode(maintenance ,forKey: .maintenance)
        try container.encode(maintenanceMessage ,forKey: .maintenanceMessage)
        try container.encode(error ,forKey: .error)
    }
}
