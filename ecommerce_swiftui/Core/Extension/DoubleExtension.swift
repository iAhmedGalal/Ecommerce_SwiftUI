//
//  DoubleExtension.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 23/09/2025.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
