//
//  LoginViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 17/09/2025.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var path = NavigationPath()

    @Published var userData: UserModel = UserModel()
    
    @Published var mailTF: String = ""
    @Published var passwordTF: String = ""
    
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSuccess: Bool = false
    @Published var rememberMe: Bool = false
    
    @Published var toast: Toast?

    private var cancellables = Set<AnyCancellable>()
    
    let userMailKey = "userMailKey"
    let userPasswordKey = "userPasswordKey"
    
    func storeUserCredentials() {
        UserDefaults.standard.set(mailTF, forKey: userMailKey)
        UserDefaults.standard.set(passwordTF, forKey: userPasswordKey)
    }
    
    func removeUserCredentials() {
        UserDefaults.standard.removeObject(forKey: userMailKey)
        UserDefaults.standard.removeObject(forKey: userPasswordKey)
    }
    
    func getUserCredentials() {
        mailTF = UserDefaults.standard.string(forKey: userMailKey) ?? ""
        passwordTF = UserDefaults.standard.string(forKey: userPasswordKey) ?? ""
        
        if !mailTF.isEmpty && !passwordTF.isEmpty {
            rememberMe = true
        }
    }
    
    func login() {
        guard !mailTF.isEmpty, !passwordTF.isEmpty else {
            errorMessage = "Please enter email and password"
            return
        }
        
        isLoading = true
        errorMessage = nil
        isSuccess = false

        let params = [
            "tele": mailTF,
            "password": passwordTF,
            "shop_id": SHOP_ID,
            "device_key": "deviceKey",
            "player_id": "playerId"
        ] as [String : Any]
        
        print("params", params)
        
        rememberMe ? storeUserCredentials() : removeUserCredentials()
        
        let request = APIRequest(path: Urls.login, method: .POST, parameters: params, requiresAuth: false)

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
                    path.append("home")
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
