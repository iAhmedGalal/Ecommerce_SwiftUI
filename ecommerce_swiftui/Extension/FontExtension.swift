//
//  FontExtension.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//
import SwiftUI

extension Font {
    static func jfFont(size: CGFloat) -> Font {
        return .custom("JFFlat-Regular", size: size)
    }
    
    static func jfFontBold(size: CGFloat) -> Font {
        return .custom("JFFlat-Bold", size: size)
    }
}
