//
//  Product.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    case foods = "Alimentos"
    case electronics = "Eletrônicos"
    case home = "Casa"
    var id: String { rawValue }
}

struct Product: Identifiable, Equatable, Hashable {
    let id: UUID
    let name: String
    let brand: String
    let category: Category
    let price: Double
    let description: String?

    init(id: UUID = .init(), name: String, brand: String, category: Category, price: Double, description: String? = nil) {
        self.id = id; self.name = name; self.brand = brand; self.category = category; self.price = price; self.description = description
    }
}
 
