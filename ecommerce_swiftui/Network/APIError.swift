//
//  APIError.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case decodingError
    case serverError(String)
    case unauthorized
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "الرابط غير صحيح"
        case .decodingError: return "فشل في قراءة البيانات"
        case .serverError(let message): return "خطأ من السيرفر: \(message)"
        case .unauthorized: return "غير مصرح بالدخول"
        case .unknown: return "خطأ غير معروف"
        }
    }
}
