//
//  ShopApp.swift
//  ShopApp
//
//  Created by Santos, Adriano da Silva on 09/05/26.
//

import SwiftUI

@main
struct ShopApp: App {
    @StateObject private var cartVM = CartViewModel()
    @StateObject private var catalogVM = CatalogViewModel()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(cartVM)
                .environmentObject(catalogVM)
        }
    }
}
