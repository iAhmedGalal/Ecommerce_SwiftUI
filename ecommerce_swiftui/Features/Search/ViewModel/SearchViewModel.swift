//
//  SearchViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 14/10/2025.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var itemsList: [ItemsModel] = []
    
    @Published var searchTF: String = ""

    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSuccess: Bool = false
    
    @Published var toast: Toast?

    @Published var saerchPage = 1
    @Published var searchLastPage = 1

    private var cancellables = Set<AnyCancellable>()
    
    func fetchSearchResults(page: Int) {
        guard !searchTF.isEmpty else {
            return
        }
        
        isLoading = true
        errorMessage = nil
        isSuccess = false

        let params = [
            "name": searchTF,
            "page": saerchPage,
            "shop_id": SHOP_ID
        ] as [String : Any]
        
        print("params", params)
                
        let request = APIRequest(path: Urls.search, method: .POST, parameters: params, requiresAuth: true)

        NetworkManager.shared.request(request, responseType: APIResponse<PaginationResponse<ItemsModel>>.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if response.status == false {
                    self.errorMessage = "noData".tr()
                    return
                }
                        
                if (response.items?.data ?? []).isEmpty {
                    self.errorMessage = "noData".tr()
                    return
                }
                
                if (self.saerchPage == 1) {
                    self.itemsList = response.items?.data ?? []
                } else {
                    self.itemsList.append(contentsOf: response.items?.data ?? [])
                }
                
                self.searchLastPage = response.items?.pagination?.last_page ?? 1
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Pagination
    func loadMoreItems() {
        if (saerchPage < searchLastPage) {
            saerchPage += 1
            fetchSearchResults(page: saerchPage)
        }
    }
    
    func loadMoreItemsIfNeeded(currentItem: ItemsModel) {
        guard !isLoading, currentItem == itemsList.last else { return }
        loadMoreItems()
    }
}
