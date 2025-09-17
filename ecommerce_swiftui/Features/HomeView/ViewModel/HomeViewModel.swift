//
//  HomeViewModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var sliderList: [SliderModel] = []
    @Published var categoriesList: [CategoriesModel] = []
    @Published var companiesList: [CompaniesModel] = []
    @Published var discountsList: [ItemsModel] = []
    @Published var bestSellerList: [ItemsModel] = []
    @Published var newItemsList: [ItemsModel] = []

//    @Published var newUser: UserResponse?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchSlider() {
        isLoading = true
        let request = APIRequest(path: Urls.slider, method: .GET, parameters: nil, requiresAuth: false)
        
        NetworkManager.shared.request(request, responseType: APIResponse<[SliderModel]>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                self?.sliderList = response.data ?? []
            }
            .store(in: &cancellables)
    }
    
    func fetchCategories() {
        isLoading = true
        let request = APIRequest(path: Urls.categoryList, method: .GET, parameters: nil, requiresAuth: false)
                
        NetworkManager.shared.request(request, responseType: APIResponse<[CategoriesModel]>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
                
            } receiveValue: { [weak self] response in
                self?.categoriesList = response.data ?? []
            }
            .store(in: &cancellables)
    }
    
    func fetchCompanies() {
        isLoading = true
        let request = APIRequest(path: Urls.companyList, method: .GET, parameters: nil, requiresAuth: false)
        
        NetworkManager.shared.request(request, responseType: APIResponse<[CompaniesModel]>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                self?.companiesList = response.data ?? []
            }
            .store(in: &cancellables)
    }
    
    func fetchDiscounts() {
        isLoading = true
        let request = APIRequest(path: Urls.discountsList, method: .GET, parameters: nil, requiresAuth: false)
        
        NetworkManager.shared.request(request, responseType: APIResponse<PaginationResponse<ItemsModel>>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                self?.discountsList = response.items?.data ?? []
            }
            .store(in: &cancellables)
    }
    
    func fetchBestSeller() {
        isLoading = true
        let request = APIRequest(path: Urls.mostOrderList, method: .GET, parameters: nil, requiresAuth: false)
        
        NetworkManager.shared.request(request, responseType: APIResponse<PaginationResponse<ItemsModel>>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                self?.bestSellerList = response.items?.data ?? []
            }
            .store(in: &cancellables)
    }
    
    func fetchNewItems() {
        isLoading = true
        let request = APIRequest(path: Urls.recentlyAddList, method: .GET, parameters: nil, requiresAuth: false)
        
        NetworkManager.shared.request(request, responseType: APIResponse<[ItemsModel]>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                self?.newItemsList = response.items ?? []
            }
            .store(in: &cancellables)
    }
    
//    func createUser(name: String, email: String) {
//        isLoading = true
//        let params = ["name": name, "email": email]
//        let request = APIRequest(path: "/users", method: .POST, parameters: params, requiresAuth: true)
//        
//        NetworkManager.shared.request(request, responseType: UserResponse.self)
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] completion in
//                self?.isLoading = false
//                if case let .failure(error) = completion {
//                    self?.errorMessage = error.errorDescription
//                }
//            } receiveValue: { [weak self] user in
//                self?.newUser = user
//            }
//            .store(in: &cancellables)
//    }
}
