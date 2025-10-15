//
//  CategoriesViewModel.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 15/10/2025.
//

import SwiftUI
import Combine

class CategoriesViewModel: ObservableObject {
    @Published var categoriesList: [CategoriesModel] = []
    @Published var subCategoriesList: [CategoriesModel] = []
    @Published var companiesList: [CompaniesModel] = []
    @Published var itemsList: [ItemsModel] = []

    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSuccess: Bool = false
    
    @Published var page = 1
    @Published var lastPage = 1

    @Published var selectedCategoryId: Int = 0
    @Published var selectedSubCategoryId: Int = 0
    @Published var selectedCompanyId: Int = 0
    
    @Published var itemPriceFrom: Double = 0
    @Published var itemPriceTo: Double = 10000

    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchCategories() {
        isLoading = true
        let request = APIRequest(path: Urls.categoryList, method: .GET, parameters: nil, requiresAuth: false)
                
        NetworkManager.shared.request(request, responseType: APIResponse<[CategoriesModel]>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
//                    self?.errorMessage = error.errorDescription
                }
                
            } receiveValue: { [weak self] response in
                if response.status == false {
//                    self?.errorMessage = "noData".tr()
                    return
                }
                        
                if (response.data ?? []).isEmpty {
//                    self?.errorMessage = "noData".tr()
                    return
                }
                
                self?.categoriesList = response.data ?? []
            }
            .store(in: &cancellables)
    }
    
    func fetchSubCategories() {
        isLoading = true
        let url = String(format: Urls.subCategoryList, "\(selectedCategoryId)")
        let request = APIRequest(path: url, method: .GET, parameters: nil, requiresAuth: false)
                
        NetworkManager.shared.request(request, responseType: APIResponse<[CategoriesModel]>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
//                    self?.errorMessage = error.errorDescription
                }
                
            } receiveValue: { [weak self] response in
                if response.status == false {
//                    self?.errorMessage = "noData".tr()
                    return
                }
                        
                if (response.data ?? []).isEmpty {
//                    self?.errorMessage = "noData".tr()
                    return
                }
                
                self?.subCategoriesList = response.data ?? []
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
//                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                if response.status == false {
//                    self?.errorMessage = "noData".tr()
                    return
                }
                        
                if (response.data ?? []).isEmpty {
//                    self?.errorMessage = "noData".tr()
                    return
                }
                
                self?.companiesList = response.data ?? []
            }
            .store(in: &cancellables)
    }
    
    func fetchCategoryItems(page: Int) {
        isLoading = true
        errorMessage = nil
        isSuccess = false
        itemsList.removeAll()

        let params = [
            "company_id": selectedCompanyId,
            "priceFrom": itemPriceFrom,
            "priceTo": itemPriceTo,
            "page": page
        ] as [String : Any]
        
        print("params", params)
        
        let url = String(format: Urls.productsList, "\(selectedCategoryId)")
        
        let request = APIRequest(path: url, method: .GET, parameters: params, requiresAuth: true)

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
                
                if (self.page == 1) {
                    self.itemsList = response.items?.data ?? []
                } else {
                    self.itemsList.append(contentsOf: response.items?.data ?? [])
                }
                
                self.lastPage = response.items?.pagination?.last_page ?? 1
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Pagination
    func loadMoreItems() {
        if (page < lastPage) {
            page += 1
            fetchCategoryItems(page: page)
        }
    }
    
    func loadMoreItemsIfNeeded(currentItem: ItemsModel) {
        guard !isLoading, currentItem == itemsList.last else { return }
        loadMoreItems()
    }
}
