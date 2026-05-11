//
//  CartViewModel.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import Foundation
import Combine

final class CartViewModel: ObservableObject {
    @Published private(set) var items: [CartItem] = []

    var total: Double {
        items.reduce(0) { $0 + (Double($1.quantity) * $1.product.price) }
    }

    func add(_ product: Product, qty: Int = 1) {
        if let idx = items.firstIndex(where: { $0.product == product }) {
            items[idx].quantity += qty
        } else {
            items.append(CartItem(product: product, quantity: qty))
        }
    }

    func updateQuantity(for item: CartItem, quantity: Int) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        if quantity <= 0 {
            items.remove(at: idx)
        } else {
            items[idx].quantity = quantity
        }
    }

    func remove(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }

    func clear() {
        items.removeAll()
    }
}
