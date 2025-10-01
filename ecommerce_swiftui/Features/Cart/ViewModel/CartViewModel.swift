//
//  CartViewModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 30/09/2025.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartModel] = []
    
    private let cartKey = "offline_cart"
    
    init() {
        loadCart()
    }
    
    // إضافة صنف
    func addItem(item: ItemsModel, selectedQty: Int, unitIndex: Int) {
        let selectedUnitData = item.unitsArr?[unitIndex]
        
        var newItem = CartModel()
        
        newItem.id = item.id ?? 0
        newItem.name = item.itemName ?? ""
        newItem.notes = item.name ?? ""
        newItem.image = item.img ?? ""
        newItem.notes = item.notes ?? ""
        newItem.isMainItem = false
        newItem.vatState = item.vatState ?? 0
        newItem.offerId = item.offerId ?? 0
        newItem.hasOffer = item.hasOffer ?? 0
        newItem.sizeId = item.sizeId ?? 0
        newItem.colorId = item.colorId ?? 0
        newItem.cartId = "\(item.id ?? 0)-\(selectedUnitData?.unit_id ?? 0)"
        newItem.selectedQuantity = selectedQty
        newItem.unitId = selectedUnitData?.unit_id ?? 0
        newItem.unitName = selectedUnitData?.unit_name ?? ""
        newItem.quantity = selectedUnitData?.quantity ?? 0
        newItem.maxQuantity = selectedUnitData?.final_max_quantity ?? 0
        newItem.newPrice = selectedUnitData?.new_price ?? ""
        newItem.salePrice = selectedUnitData?.sale_price ?? ""
        newItem.discount = selectedUnitData?.discount ?? ""
        newItem.discountType = selectedUnitData?.discount_type ?? 0
        newItem.hasDiscount = selectedUnitData?.has_discount ?? 0
        newItem.remainDiscountQuantity = selectedUnitData?.remain_discount_quantity ?? 0
        
        cartItems.append(newItem)
        saveCart()
    }
    
    // تعديل الكمية
    func updateQuantity(productId: Int, quantity: Int) {
        guard let index = cartItems.firstIndex(where: { $0.id == productId }) else { return }
        cartItems[index].selectedQuantity = max(1, quantity)
    }
    
    // حذف صنف
    func removeItem(productId: Int) {
        cartItems.removeAll { $0.id == productId }
    }
    
    // التحقق من وجود صنف
    func containsItem(productId: Int, unitId: Int) -> Bool {
        cartItems.contains { $0.cartId == "\(productId)-\(unitId)" }
    }
    
    // إجمالي
    func totalItems() -> Int {
        cartItems.reduce(0) { $0 + ($1.selectedQuantity ?? 0) }
    }
    
    // MARK: - Persistence
    private func saveCart() {
        if let encoded = try? JSONEncoder().encode(cartItems) {
            UserDefaults.standard.set(encoded, forKey: cartKey)
        }
    }
    
    private func loadCart() {
        if let data = UserDefaults.standard.data(forKey: cartKey),
           let decoded = try? JSONDecoder().decode([CartModel].self, from: data) {
            self.cartItems = decoded
        }
    }
}
