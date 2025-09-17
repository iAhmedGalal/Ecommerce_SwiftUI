//
//  APIRequest.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

struct APIRequest {
    let path: String
    let method: HTTPMethod
    let parameters: [String: Any]?
    let requiresAuth: Bool
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: mainUrl + "\(path)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(envType, forHTTPHeaderField: "env-type")
        
        if requiresAuth {
            request.setValue("Bearer \(AuthManager.shared.token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
