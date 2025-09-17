//
//  NetworkManager.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import Combine
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(_ apiRequest: APIRequest, responseType: T.Type, retries: Int = 1) -> AnyPublisher<T, APIError> {
        guard let request = apiRequest.urlRequest else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .handleEvents(receiveOutput: { data, response in
                if let httpResponse = response as? HTTPURLResponse {
                    print("📡 Status Code: \(httpResponse.statusCode)")
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("📦 Raw JSON:\n\(jsonString)")
                }
            })
            .tryMap { result -> Data in
                if let response = result.response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200...299:
                        return result.data
                    case 401:
                        throw APIError.unauthorized
                    default:
                        let message = String(data: result.data, encoding: .utf8) ?? "خطأ غير معروف"
                        throw APIError.serverError(message)
                    }
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if let apiError = error as? APIError { return apiError }
                if error is DecodingError {
                    self.printDecodingError(error as! DecodingError)
                    return .decodingError
                }
                return .unknown
            }
            .retry(retries)
            .eraseToAnyPublisher()
    }
    
    private func printDecodingError(_ error: DecodingError) {
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
