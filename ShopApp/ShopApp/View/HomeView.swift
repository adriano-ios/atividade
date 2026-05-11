//
//  HomeView.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import SwiftUI  

struct HomeView: View {
    @EnvironmentObject var catalogVM: CatalogViewModel
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        List {
            Section("Destaques") {
                ForEach(catalogVM.products.prefix(4)) { p in
                    NavigationLink(value: p) {
                        ProductRowView(product: p)
                    }
                }
            }
        }
        .navigationTitle("Loja")
        .navigationDestination(for: Product.self) { product in
            ProductDetailView(product: product)
        }
    }
}
