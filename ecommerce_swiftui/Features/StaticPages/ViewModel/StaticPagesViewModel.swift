//
//  StaticPagesViewModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 23/09/2025.
//

import SwiftUI
import Combine
import Foundation
import UIKit

class StaticPagesViewModel: ObservableObject {
    @Published var aboutText: String = ""
    @Published var termsText: String = ""

    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func getAbout() {
        isLoading = true
        let request = APIRequest(path: Urls.aboutUsURL, method: .GET, parameters: nil, requiresAuth: false)
        
        NetworkManager.shared.request(request, responseType: APIResponse<StaticPagesModel>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                self?.aboutText = response.data?.about?.html2String ?? ""
            }
            .store(in: &cancellables)
    }
    
    func getTerms() {
        isLoading = true
        let request = APIRequest(path: Urls.termsOfUseURL, method: .GET, parameters: nil, requiresAuth: false)
        
        NetworkManager.shared.request(request, responseType: APIResponse<StaticPagesModel>.self, retries: 2)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.errorDescription
                }
            } receiveValue: { [weak self] response in
                self?.termsText = response.data?.shopTerms?.html2String ?? ""
            }
            .store(in: &cancellables)
    }
}
