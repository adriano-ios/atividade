//
//  CatalogViewModel.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import Foundation
import Combine

final class CatalogViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []

    init() {
        loadSample()
    }

    func loadSample() {
        products = [
            Product(name: "Café Torrado", brand: "BomGrão", category: .foods, price: 12.90, description: "Pacote 500g"),
            Product(name: "Smartphone X", brand: "Byte", category: .electronics, price: 2499.00, description: "6.5\" - 128GB"),
            Product(name: "Liquidificador", brand: "MixHome", category: .home, price: 199.90, description: "Potente 800W"),
            Product(name: "Biscoito Integral", brand: "Saudável", category: .foods, price: 4.50),
            Product(name: "Fone Bluetooth", brand: "SoundUp", category: .electronics, price: 299.00)
        ]
    }

    func products(for category: Category?) -> [Product] {
        guard let c = category else { return products }
        return products.filter { $0.category == c }
    }
}
