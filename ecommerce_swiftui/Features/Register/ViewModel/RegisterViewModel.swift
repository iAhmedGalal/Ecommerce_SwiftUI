//
//  RegisterViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 18/09/2025.
//

import SwiftUI
import Combine

class RegisterViewModel: ObservableObject {
//    @FocusState var focusedField: String = ""  // بنحتفظ بالـ Focus هنا

    @Published var userData: UserModel = UserModel()
    
    @Published var nameTF: String = ""
    @Published var mailTF: String = ""
    @Published var phoneTF: String = ""
    @Published var addressTF: String = ""
    @Published var passwordTF: String = ""
    @Published var confirmPasswordTF: String = ""
    
    @Published var lat: String = ""
    @Published var lon: String = ""
    @Published var userType: Int = 0
    @Published var cityId: Int = 0
    
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSuccess: Bool = false
    @Published var acceptTerms: Bool = false
    
    @Published var toast: Toast?

    private var cancellables = Set<AnyCancellable>()
    
    func register() {
        guard !acceptTerms else {
            errorMessage = "يجب الموافقة على الشروط والأحكام"
            return
        }
        
        guard !nameTF.isEmpty else {
            errorMessage =  "ادخل اسم المستخدم"
            return
        }
        
        guard !mailTF.isEmpty else {
            errorMessage = "ادخل البريد الإلكتروني"
            return
        }
        
        guard Helper.isValidEmail(mail_address: mailTF) == false else {
            let message = "ادخل بريد إلكتروني صحيح"
            return
        }
        
        guard !phoneTF.isEmpty else {
            errorMessage = "ادخل رقم الجوال"
            return
        }
 
        guard Helper.isValidPhone(phone: phoneTF) == false else {
            let message = "ادخل رقم جوال صحيح"
            return
        }
        
        guard passwordTF.isEmpty == true else {
            errorMessage = "ادخل كلمة المرور"
            return
        }
        
        guard passwordTF != confirmPasswordTF else {
            errorMessage = "كلمة المرور غير متطابقة"
            return
        }
        
        isLoading = true
        errorMessage = nil
        isSuccess = false

        let params = [
            "client_name": nameTF,
            "user_name": phoneTF,
            "email": mailTF,
            "tele": phoneTF,
            "password": passwordTF,
            "player_id": "playerId",
            "device_key": "deviceKey",
            "client_type": userType,
            "address": addressTF,
            "city_id": cityId,
            "shop_name": "",
            "lat": lat,
            "lon": lon,
            "shop_id": SHOP_ID
        ] as [String : Any]
        
        print("params", params)
                
        let request = APIRequest(path: Urls.signup, method: .POST, parameters: params, requiresAuth: false)

        NetworkManager.shared.request(request, responseType: UserModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] user in
                guard let self = self else { return }

                if user.status == true {
                    self.userData = user
                    
                    SessionManager.shared.saveUser(user)
                }
                
                self.isSuccess = true
                
                toast = Toast(
                    style: user.status == false ? .error : .success,
                    message: user.msg ?? ""
                )
            }
            .store(in: &cancellables)
    }
}
