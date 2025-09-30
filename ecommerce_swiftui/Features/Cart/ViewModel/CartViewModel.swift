//
//  CartViewModel.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 30/09/2025.
//

import SwiftUI
import CoreData

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartEntity] = []
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchCart()
    }
    
    // جلب البيانات
    func fetchCart() {
        let request: NSFetchRequest<CartEntity> = CartEntity.fetchRequest()
        do {
            cartItems = try context.fetch(request)
        } catch {
            print("❌ Error fetching cart items: \(error)")
        }
    }
    
    // إضافة صنف
    func addItem(item: ItemsModel, selectedQty: Int, unitIndex: Int) {
        let selectedUnitData = item.unitsArr?[unitIndex]
        
        let newItem = CartEntity(context: context)
        newItem.id = Int64(item.id ?? 0)
        newItem.name = item.itemName ?? ""
        newItem.notes = item.name ?? ""
        newItem.image = item.img ?? ""
        newItem.notes = item.notes ?? ""
        newItem.isMainItem = false
        newItem.vatState = Int64(item.vatState ?? 0)
        newItem.offerId = Int64(item.offerId ?? 0)
        newItem.hasOffer = Int64(item.hasOffer ?? 0)
        newItem.sizeId = Int64(item.sizeId ?? 0)
        newItem.colorId = Int64(item.colorId ?? 0)
        newItem.cartId = "\(item.id ?? 0)-\(selectedUnitData?.unit_id ?? 0)"
        newItem.selectedQty = Int64(selectedQty)
        newItem.unitId = Int64(selectedUnitData?.unit_id ?? 0)
        newItem.unitName = selectedUnitData?.unit_name ?? ""
        newItem.quantity = Int64(selectedUnitData?.quantity ?? 0)
        newItem.maxQty = Int64(selectedUnitData?.final_max_quantity ?? 0)
        newItem.newPrice = selectedUnitData?.new_price ?? ""
        newItem.salePrice = selectedUnitData?.sale_price ?? ""
        newItem.discount = selectedUnitData?.discount ?? ""
        newItem.discountType = Int64(selectedUnitData?.discount_type ?? 0)
        newItem.hasDiscount = Int64(selectedUnitData?.has_discount ?? 0)
        newItem.remainDiscountQuantity = Int64(selectedUnitData?.remain_discount_quantity ?? 0)

        cartItems.append(newItem)
        saveContext()
    }
    
    // تعديل الكمية
    func updateQuantity(item: CartEntity, quantity: Int) {
        item.selectedQty = Int64(max(1, quantity))
        saveContext()
    }
    
    // حذف صنف
    func removeItem(item: CartEntity) {
        context.delete(item)
        saveContext()
    }
    
    // التحقق من وجود صنف
    func containsItem(productId: Int, unitId: Int) -> Bool {
        cartItems.contains { $0.cartId == "\(productId)-\(unitId)" }
    }
    
    // إجمالي
    func totalItems() -> Int {
        cartItems.reduce(0) { $0 + Int($1.selectedQty) }
    }
    
    // حفظ
    private func saveContext() {
        do {
            try context.save()
            fetchCart()
        } catch {
            print("❌ Error saving context: \(error)")
        }
    }
}
