//
//  StringExtension.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 21/09/2025.
//

import SwiftUI

extension String {
    var tr: String {
        String(localized: String.LocalizationValue(self))
    }
    
    func tr(with variables: [String: String]) -> String {
        var localizedString = String(localized: String.LocalizationValue(self))
        for (key, value) in variables {
            localizedString = localizedString.replacingOccurrences(of: "{\(key)}", with: value)
        }
        return localizedString
    }
}
