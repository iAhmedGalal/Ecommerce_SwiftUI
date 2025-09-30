//
//  ContactsViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 28/09/2025.
//

import SwiftUI
import Combine

class ContactsViewModel: ObservableObject {
    @Published var settings: ContactsSettingsModel = ContactsSettingsModel()
    @Published var social: [ContactsSocialModel] = []

    @Published var nameTF: String = ""
    @Published var mailTF: String = ""
    @Published var phoneTF: String = ""
    @Published var titleTF: String = ""
    @Published var messageTF: String = ""
    
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSuccess: Bool = false
    
    @Published var toast: Toast?
    
    var navigateToHome = false

    private var cancellables = Set<AnyCancellable>()
    
    func showErrorToast() {
        toast = Toast(
            style: .error,
            message: errorMessage ?? ""
        )
    }
    
    func sendMessage() {
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
    
        guard !titleTF.isEmpty else {
            errorMessage = "ادخل عنوان الرسالة"
            showErrorToast()
            return
        }
        
        guard !messageTF.isEmpty else {
            errorMessage = "ادخل نص الرسالة"
            showErrorToast()
            return
        }
        
        isLoading = true
        errorMessage = nil
        isSuccess = false
        
        let params = [
            "name": nameTF,
            "email": mailTF,
            "phone": phoneTF,
            "title": titleTF,
            "message": messageTF,
            "shop_id": SHOP_ID
        ] as [String : Any]

        print("params", params)
                
        let request = APIRequest(path: Urls.callUsURL, method: .POST, parameters: params, requiresAuth: false)

        NetworkManager.shared.request(request, responseType: APIResponse<ContactsModel>.self)
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
                        message: user.message ?? ""
                    )
                    
                    return
                }
                                                    
                toast = Toast(
                    style: .success,
                    message: user.msg ?? ""
                )
                
                navigateToHome = true
            }
            .store(in: &cancellables)
    }
    
    func getContacts() {
        let request = APIRequest(path: Urls.callUsURL, method: .GET, parameters: nil, requiresAuth: false)

        NetworkManager.shared.request(request, responseType: ContactsModel.self)
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

                self.settings = response.settings ?? ContactsSettingsModel()
                self.social = response.social ?? []
            }
            .store(in: &cancellables)
    }
}
