//
//  SafeDecode.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 15/09/2025.
//

import Foundation

@propertyWrapper
struct SafeDecode<T: Decodable>: Decodable {
    var wrappedValue: T

    init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()

        // المفتاح مش موجود أو null
        if container == nil || (container?.decodeNil() ?? false) {
            wrappedValue = SafeDecode.defaultValue(for: T.self)
            return
        }

        // جرب النوع الأصلي
        if let value = try? container?.decode(T.self) {
            wrappedValue = value
            return
        }

        // fallback للتحويل بين الأنواع
        wrappedValue = SafeDecode.decodeWithFallback(container: container!, type: T.self)
    }

    // Default values لأي نوع
    static func defaultValue<U>(for type: U.Type) -> U {
        switch type {
        case is String.Type: return "" as! U
        case is Int.Type: return 0 as! U
        case is Double.Type: return 0.0 as! U
        case is Bool.Type: return false as! U
        default:
            if let optionalType = type as? ExpressibleByNilLiteral.Type {
                return optionalType.init(nilLiteral: ()) as! U
            }
            fatalError("نوع غير مدعوم: \(type)")
        }
    }

    // التحويل بين الأنواع المختلفة
    static func decodeWithFallback<U: Decodable>(container: SingleValueDecodingContainer, type: U.Type) -> U {
        if type == String.self {
            if let intValue = try? container.decode(Int.self) { return String(intValue) as! U }
            if let doubleValue = try? container.decode(Double.self) { return String(doubleValue) as! U }
            if let boolValue = try? container.decode(Bool.self) { return String(boolValue) as! U }
            return "" as! U
        }

        if type == Int.self {
            if let stringValue = try? container.decode(String.self), let intValue = Int(stringValue) { return intValue as! U }
            return 0 as! U
        }

        if type == Double.self {
            if let stringValue = try? container.decode(String.self), let doubleValue = Double(stringValue) { return doubleValue as! U }
            return 0.0 as! U
        }

        if type == Bool.self {
            if let stringValue = try? container.decode(String.self) { return (stringValue == "true" || stringValue == "1") as! U }
            if let intValue = try? container.decode(Int.self) { return (intValue != 0) as! U }
            return false as! U
        }

        return SafeDecode.defaultValue(for: type)
    }
}
