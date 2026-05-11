//
//  ProductRowView.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.name).font(.headline)
                Text(product.brand).font(.caption).foregroundColor(.secondary)
            }
            Spacer()
            Text("R$ \(product.price, specifier: "%.2f")").bold()
        }
        .padding(.vertical, 6)
    }
}
