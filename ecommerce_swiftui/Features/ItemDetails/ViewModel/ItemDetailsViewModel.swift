//
//  ItemDetailsViewModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 14/09/2025.
//

import SwiftUI
import Combine

class ItemDetailsViewModel: ObservableObject {
    @Published var item = ItemsModel()
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func getItemDetails(id: Int) {
        isLoading = true
        
        let url = String(format: Urls.itemDetails, "\(id)")
        
        let request = APIRequest(path: url, method: .GET, parameters: nil, requiresAuth: true)
                
        NetworkManager.shared.request(request, responseType: APIResponse<ItemsModel>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
                
            } receiveValue: { [weak self] response in
                self?.item = response.item ?? ItemsModel()
            }
            .store(in: &cancellables)
    }

}
