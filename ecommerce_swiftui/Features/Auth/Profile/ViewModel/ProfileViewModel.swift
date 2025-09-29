//
//  ProfileViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 29/09/2025.
//

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    @Published var userData: UserModel = UserModel()
    
    @Published var nameTF: String = ""
    @Published var mailTF: String = ""
    @Published var phoneTF: String = ""
    
    
    @Published var passwordTF: String = ""
    @Published var newPasswordTF: String = ""
    @Published var confirmNewPasswordTF: String = ""
        
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSuccess: Bool = false
    
    @Published var toast: Toast?
    
    @Published var showEditPassword = false
    @Published var showDeleteWarning = false
   
    var navigateToHome = false
    var navigateToLogin = false

    private var cancellables = Set<AnyCancellable>()
    
    func showErrorToast() {
        toast = Toast(
            style: .error,
            message: errorMessage ?? ""
        )
    }
    
    func editProfile() {
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
        
        isLoading = true
        errorMessage = nil
        isSuccess = false

        let params = [
            "client_name": nameTF,
            "email": mailTF,
            "mobile": phoneTF,
        ] as [String : Any]
                        
        let request = APIRequest(path: Urls.editProfile, method: .POST, parameters: params, requiresAuth: true)

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
                        message: user.msg ?? ""
                    )
                    
                    return
                }

                self.userData.clientName = nameTF
                self.userData.phone = phoneTF
                self.userData.email = mailTF
                   
                SessionManager.shared.saveUser(self.userData)
                    
                navigateToHome = true
                                
                toast = Toast(
                    style: .success,
                    message: user.msg ?? ""
                )
            }
            .store(in: &cancellables)
    }
    
    func changePassword() {
        guard !passwordTF.isEmpty == true else {
            errorMessage = "ادخل كلمة المرور الحالية"
            showErrorToast()
            return
        }

        guard !newPasswordTF.isEmpty == true else {
            errorMessage = "ادخل كلمة المرور الجديدة"
            showErrorToast()
            return
        }
        
        guard newPasswordTF == confirmNewPasswordTF else {
            errorMessage = "كلمة المرور غير متطابقة"
            showErrorToast()
            return
        }
        
        isLoading = true
        errorMessage = nil
        isSuccess = false

        let params = [
            "client_name": nameTF,
            "email": mailTF,
            "mobile": phoneTF,
            "current_password": passwordTF,
            "password": newPasswordTF,
            "password_confirmation": confirmNewPasswordTF,
        ] as [String : Any]
                        
        let request = APIRequest(path: Urls.editProfile, method: .POST, parameters: params, requiresAuth: true)

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
                        message: user.msg ?? ""
                    )
                    
                    return
                }
                
                self.userData.clientName = nameTF
                self.userData.phone = phoneTF
                self.userData.email = mailTF
                   
                SessionManager.shared.saveUser(self.userData)
                    
                navigateToHome = true
                                
                toast = Toast(
                    style: .success,
                    message: user.msg ?? ""
                )
            }
            .store(in: &cancellables)
    }
    
    func deleteAccount() {
        let request = APIRequest(path: Urls.DELETE_ACCOUNT_ENDPOINT, method: .POST, parameters: nil, requiresAuth: true)

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

                navigateToLogin = true
            }
            .store(in: &cancellables)
    }
    
    func showUserData() {
        userData = SessionManager.shared.currentUser ?? UserModel()
        
        nameTF = userData.clientName ?? ""
        phoneTF = userData.phone ?? ""
        mailTF = userData.email ?? ""
    }
}
