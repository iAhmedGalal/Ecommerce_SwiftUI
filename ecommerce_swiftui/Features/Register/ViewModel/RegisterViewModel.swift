//
//  RegisterViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 18/09/2025.
//

import SwiftUI
import Combine
import MapKit

class RegisterViewModel: ObservableObject {
    @Published var userData: UserModel = UserModel()
    
    @Published var regionsList: [RegionsModel] = []
    @Published var selectedCity: RegionsModel = RegionsModel()
    
    @Published var nameTF: String = ""
    @Published var mailTF: String = ""
    @Published var phoneTF: String = ""
    @Published var addressTF: String = ""
    @Published var passwordTF: String = ""
    @Published var confirmPasswordTF: String = ""
    
    @Published var userType: Int = 0
    
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSuccess: Bool = false
    @Published var acceptTerms: Bool = false
    
    @Published var toast: Toast?
    
    @Published var showMap = false
    @Published var selectedCoordinate: CLLocationCoordinate2D?
    
    var navigateToLogin = false

    private var cancellables = Set<AnyCancellable>()
    
    func showErrorToast() {
        toast = Toast(
            style: .error,
            message: errorMessage ?? ""
        )
    }
    
    func register() {
        guard acceptTerms else {
            errorMessage = "يجب الموافقة على الشروط والأحكام"
            showErrorToast()
            return
        }
        
        guard !nameTF.isEmpty else {
            errorMessage =  "ادخل اسم المستخدم"
            showErrorToast()
            return
        }
        
        guard !mailTF.isEmpty else {
            errorMessage = "ادخل البريد الإلكتروني"
            showErrorToast()
            return
        }
        
        guard Helper.isValidEmail(mail_address: mailTF) else {
            errorMessage = "ادخل بريد إلكتروني صحيح"
            showErrorToast()
            return
        }
        
        guard !phoneTF.isEmpty else {
            errorMessage = "ادخل رقم الجوال"
            showErrorToast()
            return
        }
 
        guard Helper.isValidPhone(phone: phoneTF) else {
            errorMessage = "ادخل رقم جوال صحيح"
            showErrorToast()
            return
        }
        
        let cityId =  selectedCity.id ?? 0

        guard cityId != 0 else {
            errorMessage = "chooseCity".tr()
            showErrorToast()
            return
        }
        
        let lat = selectedCoordinate?.latitude ?? 0.0
        let lon = selectedCoordinate?.longitude ?? 0.0
        
        guard lat != 0.0 || lon != 0.0 else {
            errorMessage = "اختر العنوان من الخريطة"
            showErrorToast()
            return
        }
        
        guard !addressTF.isEmpty else {
            errorMessage = "اختر العنوان من الخريطة"
            showErrorToast()
            return
        }
        
        guard !passwordTF.isEmpty == true else {
            errorMessage = "ادخل كلمة المرور"
            showErrorToast()
            return
        }
        
        guard passwordTF == confirmPasswordTF else {
            errorMessage = "كلمة المرور غير متطابقة"
            showErrorToast()
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
            "lat": selectedCoordinate?.latitude ?? 0.0,
            "lon": selectedCoordinate?.longitude ?? 0.0,
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
                
                self.isSuccess = true

                if (user.status == false) {
                    toast = Toast(
                        style: .error,
                        message: user.error?.first ?? ""
                    )
                    
                    return
                }

                self.userData = user
                   
                SessionManager.shared.saveUser(user)
                    
                navigateToLogin = true
                                
                toast = Toast(
                    style: .success,
                    message: user.msg ?? ""
                )
            }
            .store(in: &cancellables)
    }
    
    func getRegions() {
        let request = APIRequest(path: Urls.regionsList, method: .GET, parameters: nil, requiresAuth: false)

        NetworkManager.shared.request(request, responseType: APIResponse<[RegionsModel]>.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                self.isSuccess = true

                if (response.status == false) {
                    return
                }

                regionsList = response.data ?? []
            }
            .store(in: &cancellables)
    }
}
