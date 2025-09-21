import SwiftUI
import UIKit

class LanguageManager: ObservableObject {
    @Published var currentLocale: Locale
    
    init() {
        currentLocale = Locale(identifier: "ar")
    }
    
    func changeLanguage(to languageCode: String) {
        currentLocale = Locale(identifier: languageCode)
        
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
