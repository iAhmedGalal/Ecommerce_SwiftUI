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
        var components = URLComponents(string: mainUrl + path)
        var queryItems: [URLQueryItem] = []
        
        // لو محتاج Auth بنضيف التوكن في query
        if requiresAuth, let token = SessionManager.shared.currentUser?.token {
            queryItems.append(URLQueryItem(name: "api_token", value: token))
        }
        
        // لو GET → الباراميترات تتحول لـ query parameters
        if method == .GET, let parameters = parameters {
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        
        if !queryItems.isEmpty {
            components?.queryItems = queryItems
        }
        
        guard let finalUrl = components?.url else { return nil }
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method.rawValue
        
        // لو POST أو PUT أو DELETE → الباراميترات في الـ body
        if method != .GET, let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(envType, forHTTPHeaderField: "env-type")
        
        return request
    }
}

