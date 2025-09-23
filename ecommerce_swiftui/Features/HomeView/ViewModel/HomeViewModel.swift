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

    @Published var errorMessage: String?
    @Published var isLoading = false
    
    @Published var discountsPage = 1
    @Published var discountsLastPage = 1

    @Published var bestSellerPage = 1
    @Published var bestSellerLastPage = 1
    
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
    
    func fetchDiscounts(page: Int) {
        isLoading = true
        
        let params = ["page": "\(page)"]
        
        let request = APIRequest(path: Urls.discountsList, method: .GET, parameters: params, requiresAuth: true)
        
        NetworkManager.shared.request(request, responseType: APIResponse<PaginationResponse<ItemsModel>>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                if (self?.discountsPage == 1) {
                    self?.discountsList = response.items?.data ?? []
                } else {
                    self?.discountsList.append(contentsOf: response.items?.data ?? [])
                }
                
                self?.discountsLastPage = response.items?.last_page ?? 1
            }
            .store(in: &cancellables)
    }
    
    func fetchBestSeller(page: Int) {
        isLoading = true
        
        let params = ["page": "\(page)"]
        
        let request = APIRequest(path: Urls.mostOrderList, method: .GET, parameters: params, requiresAuth: true)
        
        NetworkManager.shared.request(request, responseType: APIResponse<PaginationResponse<ItemsModel>>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                if (self?.bestSellerPage == 1) {
                    self?.bestSellerList = response.items?.data ?? []
                } else {
                    self?.bestSellerList.append(contentsOf: response.items?.data ?? [])
                }
                
                self?.bestSellerLastPage = response.items?.last_page ?? 1
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
    
    //MARK: - Pagination
    func loadMoreDiscounts() {
        if (discountsPage < discountsLastPage) {
            discountsPage += 1
            fetchDiscounts(page: discountsPage)
        }
    }
    
    func loadMoreBestSellers() {
        if (bestSellerPage < bestSellerLastPage) {
            bestSellerPage += 1
            fetchBestSeller(page: bestSellerPage)
        }
    }
    
    func loadMoreBestSellerIfNeeded(currentItem: ItemsModel) {
        guard !isLoading, currentItem == bestSellerList.last else { return }
        loadMoreBestSellers()
    }
    
    func loadMoreDiscountsIfNeeded(currentItem: ItemsModel) {
        guard !isLoading, currentItem == discountsList.last else { return }
        loadMoreDiscounts()
    }
}
