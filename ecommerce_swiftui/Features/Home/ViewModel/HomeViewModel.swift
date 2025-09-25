//
//  HomeViewModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import Combine
import SwiftUI

enum ItemListType {
    case bestSeller
    case newItems
    case discounts
    case favourite
    case search
    case categories
    case companies
}

class HomeViewModel: ObservableObject {
    @Published var sliderList: [SliderModel] = []
    @Published var categoriesList: [CategoriesModel] = []
    @Published var companiesList: [CompaniesModel] = []
    @Published var discountsList: [ItemsModel] = []
    @Published var bestSellerList: [ItemsModel] = []
    @Published var newItemsList: [ItemsModel] = []
    @Published var favList: [ItemsModel] = []

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
                if response.status == false {
                    self?.errorMessage = "noData".tr()
                    return
                }
                        
                if (response.data ?? []).isEmpty {
                    self?.errorMessage = "noData".tr()
                    return
                }
                
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
                if response.status == false {
                    self?.errorMessage = "noData".tr()
                    return
                }
                        
                if (response.data ?? []).isEmpty {
                    self?.errorMessage = "noData".tr()
                    return
                }
                
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
                if response.status == false {
                    self?.errorMessage = "noData".tr()
                    return
                }
                        
                if (response.items?.data ?? []).isEmpty {
                    self?.errorMessage = "noData".tr()
                    return
                }
                
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
                if response.status == false {
                    self?.errorMessage = "noData".tr()
                    return
                }
                        
                if (response.items?.data ?? []).isEmpty {
                    self?.errorMessage = "noData".tr()
                    return
                }
                
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
                if response.status == false {
                    self?.errorMessage = "noData".tr()
                    return
                }
                        
                if (response.items ?? []).isEmpty {
                    self?.errorMessage = "noData".tr()
                    return
                }
                
                self?.newItemsList = response.items ?? []
            }
            .store(in: &cancellables)
    }

    //MARK: - Favourites
    func fetchFavouritrs() {
        isLoading = true
        
        let params = [
            "api_token": SessionManager.shared.currentUser?.token ?? "",
            "client_id": SessionManager.shared.currentUser?.clientId ?? 0,
            "shop_id": SHOP_ID,
        ] as [String : Any]
        
        let request = APIRequest(path: Urls.getFavorite, method: .POST, parameters: params, requiresAuth: true)
        
        NetworkManager.shared.request(request, responseType: APIResponse<[ItemsModel]>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                if response.status == false {
                    self?.errorMessage = "noData".tr()
                    return
                }
                        
                if (response.data ?? []).isEmpty {
                    self?.errorMessage = "noData".tr()
                    return
                }
                
                self?.favList = response.data ?? []
            }
            .store(in: &cancellables)
    }
    
    func addToFavourite(itemId: Int) {
        isLoading = true
        
        let params = [
            "product_id": "\(itemId)",
            "client_id": SessionManager.shared.currentUser?.clientId ?? 0,
            "shop_id": SHOP_ID,
            "is_group": 0
        ] as [String : Any]
                
        let request = APIRequest(path: Urls.addFavorite, method: .POST, parameters: params, requiresAuth: true)
        
        NetworkManager.shared.request(request, responseType: APIResponse<UserModel>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                if response.status == false {
                    self?.errorMessage = "noData".tr()
                    return
                }
            }
            .store(in: &cancellables)
    }
    
    func removeFromFavourits(itemId: Int) {
        isLoading = true
        
        let params = [
            "product_id": "\(itemId)",
            "client_id": SessionManager.shared.currentUser?.clientId ?? 0,
            "shop_id": SHOP_ID,
            "is_group": 0
        ] as [String : Any]
                
        let request = APIRequest(path: Urls.removeFavorite, method: .POST, parameters: params, requiresAuth: true)
        
        NetworkManager.shared.request(request, responseType: APIResponse<UserModel>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                if response.status == false {
                    self?.errorMessage = "noData".tr()
                    return
                }
            }
            .store(in: &cancellables)
    }

    func updateFavoriteIcon(itemId: Int, isFav: Bool, in list: ItemListType) {
        switch list {
        case .bestSeller:
            if let index = bestSellerList.firstIndex(where: { $0.id == itemId }) {
                bestSellerList[index].fav = isFav
            }
        case .newItems:
            if let index = newItemsList.firstIndex(where: { $0.id == itemId }) {
                newItemsList[index].fav = isFav
            }
        case .discounts:
            if let index = discountsList.firstIndex(where: { $0.id == itemId }) {
                discountsList[index].fav = isFav
            }
        case .favourite:
            if let index = favList.firstIndex(where: { $0.id == itemId }) {
                favList.remove(at: index)
            }
        case .search:
            print("")
            
        case .categories:
            print("")

        case .companies:
            print("")

        }
        
        isFav ? addToFavourite(itemId: itemId) : removeFromFavourits(itemId: itemId)
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
