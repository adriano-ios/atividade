//
//  CategoriesView.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var catalogVM: CatalogViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @State private var selectedCategory: Category? = nil

    var body: some View {
        VStack {
            Picker("Categoria", selection: $selectedCategory) {
                Text("Todas").tag(Category?.none)
                ForEach(Category.allCases) { c in
                    Text(c.rawValue).tag(Category?.some(c))
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            List {
                ForEach(catalogVM.products(for: selectedCategory)) { product in
                    HStack {
                        NavigationLink(value: product) {
                            ProductRowView(product: product)
                        }
                        Spacer()
                        Button {
                            cartVM.add(product)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                        .buttonStyle(.borderless)
                    }
                }
            }
            .navigationTitle("Categorias")
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product)
            }
        }
    }
}
