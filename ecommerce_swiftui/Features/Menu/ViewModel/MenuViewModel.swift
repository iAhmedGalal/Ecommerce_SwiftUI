//
//  MenuViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 23/09/2025.
//

import SwiftUI
import Combine

class MenuViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var navigateToHome = false

    func logout() {
        isLoading = true
        
        let url = Urls.LOGOUT
        
        let request = APIRequest(path: url, method: .POST, parameters: nil, requiresAuth: true)
                
        NetworkManager.shared.request(request, responseType: APIResponse<UserModel>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
                
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                SessionManager.shared.logout()
                navigateToHome = true
            }
            .store(in: &cancellables)
    }
}
