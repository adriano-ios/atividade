//
//  ProductDetailView.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartVM: CartViewModel
    let product: Product
    @State private var qty: Int = 1

    var body: some View {
        Form {
            Section {
                Text(product.name).font(.title2).bold()
                Text(product.description ?? "").foregroundColor(.secondary)
            }
            Section {
                Stepper("Quantidade: \(qty)", value: $qty, in: 1...99)
                Button("Adicionar ao Carrinho") {
                    cartVM.add(product, qty: qty)
                }
                .buttonStyle(.borderedProminent)
            }
            Section {
                Text("Preço unitário: R$ \(product.price, specifier: "%.2f")")
            }
        }
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
