//
//  StringExtension.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 21/09/2025.
//

import SwiftUI

extension String {
    func tr() -> String {
        guard let bundle = Bundle.main.path(forResource: LocalizationManager.shared.language.rawValue, ofType: "lproj") else {
            return NSLocalizedString(self, comment: "")
        }
        
        let langBundle = Bundle(path: bundle)
        return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: "")
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
