//
//  OffersView.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import SwiftUI


struct OffersView: View {
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        VStack {
            CartView()
        }
        .navigationTitle("Carrinho")
    }
}
