//
//  CardItem.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import Foundation

struct CartItem: Identifiable, Equatable {
    let id = UUID()
    let product: Product
    var quantity: Int
}
 
