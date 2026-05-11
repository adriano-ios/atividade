//
//  RootTabView.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import SwiftUI

struct RootTabView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var catalogVM: CatalogViewModel

    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem { Label("Início", systemImage: "house") }

            NavigationStack {
                CategoriesView()
            }
            .tabItem { Label("Categorias", systemImage: "square.grid.2x2") }

            NavigationStack {
                OffersView()
            }
            .tabItem { Label("Carrinho (\(cartVM.items.count))", systemImage: "cart") }
        }
    }
}

#Preview {
    RootTabView()
        .environmentObject(CartViewModel())
        .environmentObject(CatalogViewModel())
}
