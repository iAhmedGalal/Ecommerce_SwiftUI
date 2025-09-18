//
//  LoginViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 17/09/2025.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var userData: UserModel = UserModel()
    
    @Published var mailTF: String = ""
    @Published var passwordTF: String = ""
    
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSuccess: Bool = false

    private var cancellables = Set<AnyCancellable>()
    
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

                if user.status == false {
                    self.errorMessage = user.error?.first ?? ""
                    return
                }
                
                self.userData = user
                self.isSuccess = true
                
                SessionManager.shared.saveUser(user)
            }
            .store(in: &cancellables)
    }
}
