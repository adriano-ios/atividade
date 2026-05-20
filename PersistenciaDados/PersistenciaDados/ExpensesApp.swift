//
//  ExpensesApp.swift
//  PersistenciaDados
//
//  Created by Santos, Adriano da Silva on 18/05/26.
//

import SwiftUI
import CoreData


@main
struct ExpensesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
 
