//
//  Helper.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 18/09/2025.
//

import UIKit
import Foundation

class Helper {
    static func isValidEmail(mail_address:String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: mail_address)
    }
    
    static func isValidPhone(phone:String) -> Bool {
        let phoneRegex = #"^01[0-2]\d{1,8}$"#
//        let phoneRegex = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#

        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    static func openScheme(scheme: String) {
        if let url = URL(string: scheme) {
            UIApplication.shared.open(url)
        }
    }
    
    static func openWhatsapp(number: String){
        let trimmedNumber = number.replacingOccurrences(of: " ", with: "")
        print("mobileString trimmed:"+trimmedNumber)

        var whatsappLink: String = ""
        
        if trimmedNumber.prefix(2) == "01" {
            whatsappLink = "https://api.whatsapp.com/send?phone=002\(trimmedNumber)"
        }else {
            whatsappLink = "https://api.whatsapp.com/send?phone=\(trimmedNumber)"
        }
        
        print("urlWhatsapp", whatsappLink)
        
        if let urlString = whatsappLink.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    static func callNumber(number:String) {
        if let phoneCallURL = URL(string: "telprompt://"+number) {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                }
            }
        }
    }
   
    static func shareItem(name: String, itemImage: String, shareUrl: String, vc: UIViewController) {
        let name = name
        let image = UIImage(named: "logo")
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        
        imageView.image = image
        
//        if itemImage != "" {
//            imageView.sd_setImage(with: URL(string: itemImage), placeholderImage: image)
//        }
                
        let linkString = shareUrl
        let link = NSURL(string: linkString)
        let textShare = [name, linkString, imageView.image as Any, link as Any] as [Any]
        let alert = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = vc.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.maxY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        vc.present(alert, animated: true, completion: nil)
    }
}
