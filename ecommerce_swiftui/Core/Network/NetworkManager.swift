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
                    APILogger.logRequest(request)
                    APILogger.logResponse(httpResponse, data: data)
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
                    APILogger.printDecodingError(error as! DecodingError)
                    return .decodingError
                }
                return .unknown
            }
            .retry(retries)
            .eraseToAnyPublisher()
    }
}
