//
//  APILogger.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 29/09/2025.
//

import Combine
import Foundation

struct APILogger {
    static var isEnabled: Bool = true
    
    static func log(_ message: String) {
        guard isEnabled else { return }
        print("\(message)")
    }
    
    static func logRequest(_ request: URLRequest) {
        guard isEnabled else { return }
        log("\n➡️ [REQUEST]")
        log("URL: \(request.url?.absoluteString ?? "N/A")")
        log("Method: \(request.httpMethod ?? "N/A")")
        if let headers = request.allHTTPHeaderFields {
            log("Headers: \(headers)")
        }
        if let body = request.httpBody,
           let json = try? JSONSerialization.jsonObject(with: body, options: []),
           let prettyData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            log("Body:\n\(prettyString)")
        }
    }
    
    static func logResponse(_ response: HTTPURLResponse, data: Data) {
        guard isEnabled else { return }
        log("\n⬅️ [RESPONSE]")
        log("📡 Status Code: \(response.statusCode)")
        if let json = try? JSONSerialization.jsonObject(with: data, options: []),
           let prettyData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            log("📦 Body:\n\(prettyString)")
        } else {
            log("📦 Raw Data: \(String(data: data, encoding: .utf8) ?? "")")
        }
    }
    
    static func logError(_ message: String) {
        guard isEnabled else { return }
        log("❌ [ERROR]: \(message)")
    }
    
    static func printDecodingError(_ error: DecodingError) {
        switch error {
        case .typeMismatch(let type, let context):
            print("❌ Type mismatch: \(type). Context: \(context.debugDescription)")
            print("Coding Path:", context.codingPath.map { $0.stringValue })
        case .valueNotFound(let type, let context):
            print("❌ Value not found: \(type). Context: \(context.debugDescription)")
            print("Coding Path:", context.codingPath.map { $0.stringValue })
        case .keyNotFound(let key, let context):
            print("❌ Key not found: \(key.stringValue). Context: \(context.debugDescription)")
            print("Coding Path:", context.codingPath.map { $0.stringValue })
        case .dataCorrupted(let context):
            print("❌ Data corrupted. Context: \(context.debugDescription)")
            print("Coding Path:", context.codingPath.map { $0.stringValue })
        @unknown default:
            print("❌ Unknown decoding error")
        }
    }

}
