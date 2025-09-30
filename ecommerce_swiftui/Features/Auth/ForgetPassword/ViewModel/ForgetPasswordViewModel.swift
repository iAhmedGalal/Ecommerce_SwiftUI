//
//  ForgetPasswordViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 29/09/2025.
//

import SwiftUI
import Combine

class ForgetPasswordViewModel: ObservableObject {
    @Published var mailTF: String = ""
    
    @Published var codeTF: String = ""
    @Published var newPasswordTF: String = ""
    @Published var confirmNewPasswordTF: String = ""
        
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSuccess: Bool = false
    
    @Published var toast: Toast?
   
    var navigateToLogin = false
    var navigateToResetPassword = false

    private var cancellables = Set<AnyCancellable>()
    
    func showErrorToast() {
        toast = Toast(
            style: .error,
            message: errorMessage ?? ""
        )
    }
    
    func sendResetCode() {
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
        
        isLoading = true
        errorMessage = nil
        isSuccess = false

        let params = [
            "email": mailTF,
            "shop_id": SHOP_ID
        ] as [String : Any]
                        
        let request = APIRequest(path: Urls.emailCode, method: .POST, parameters: params, requiresAuth: false)

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
                    
                self.navigateToResetPassword = true
                                
                toast = Toast(
                    style: .success,
                    message: user.msg ?? ""
                )
            }
            .store(in: &cancellables)
    }
    
    func resetPassword() {
        guard !codeTF.isEmpty == true else {
            errorMessage = "ادخل الكود"
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
            "code": codeTF,
            "shop_id": SHOP_ID,
            "email": mailTF,
            "password": newPasswordTF,
            "password_confirmation": confirmNewPasswordTF,
        ] as [String : Any]
                        
        let request = APIRequest(path: Urls.resetPassword, method: .POST, parameters: params, requiresAuth: false)

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
                    
                navigateToLogin = true
                                
                toast = Toast(
                    style: .success,
                    message: user.msg ?? ""
                )
            }
            .store(in: &cancellables)
    }
}
