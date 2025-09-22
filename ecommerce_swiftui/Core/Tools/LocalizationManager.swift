import SwiftUI
import UIKit

enum SelectedLanguage: String {
    case arabic = "ar"
    case english = "en"
}

class LocalizationManager: ObservableObject { // Mark the class as ObservableObject
    // MARK: - Variables
    static let shared = LocalizationManager()

    @AppStorage("selectedLanguage") private var languageString: String = SelectedLanguage.arabic.rawValue // First-time users would see Arabic language
    
    @Published var currentLocale: Locale = Locale(identifier: SelectedLanguage.arabic.rawValue)
    @Published var layoutDirection: LayoutDirection = .rightToLeft

    @Published var language: SelectedLanguage = .arabic { // Match the initial language with languageString
        didSet {
            languageString = language.rawValue // We save the updated language's code into storage
            currentLocale = Locale(identifier: languageString)
            
            setLayoutDirection(language: language)
            
            UserDefaults.standard.setValue(language.rawValue, forKey: "selectedLanguage")
            UserDefaults.standard.set([language.rawValue], forKey: "AppleLanguages") // Set the device's app language
            UserDefaults.standard.synchronize() // Optional as Apple does not recommend doing this
        }
    }
    
    func setLayoutDirection(language: SelectedLanguage) {
        switch language {
        case .arabic:
            layoutDirection = .rightToLeft
        case .english:
            layoutDirection = .leftToRight
        }
    }
    
    // MARK: - Init
    init() {
        // Added selected language initialization
        if let selectedLanguage = SelectedLanguage(rawValue: languageString) {
            language = selectedLanguage
            currentLocale = Locale(identifier: selectedLanguage.rawValue)
            setLayoutDirection(language: selectedLanguage)
        }
    }
}
