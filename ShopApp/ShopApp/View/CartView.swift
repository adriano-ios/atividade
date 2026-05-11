//
//  CartView.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        List {
            if cartVM.items.isEmpty {
                Text("Carrinho vazio").foregroundColor(.secondary)
            } else {
                ForEach(cartVM.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.product.name).font(.headline)
                            Text(item.product.brand).font(.caption).foregroundColor(.secondary)
                        }
                        Spacer()
                        Stepper(value: Binding(
                            get: { item.quantity },
                            set: { newQty in cartVM.updateQuantity(for: item, quantity: newQty) }
                        ), in: 0...99) {
                            Text("\(item.quantity) x R$ \(item.product.price, specifier: "%.2f")")
                        }
                    }
                }
                .onDelete { idx in
                    idx.forEach { cartVM.remove(cartVM.items[$0]) }
                }

                HStack {
                    Text("Total").bold()
                    Spacer()
                    Text("R$ \(cartVM.total, specifier: "%.2f")").bold()
                }

                Button("Remover Todos") {
                    cartVM.clear()
                }
                .tint(.red)
            }
        }
    }
}
