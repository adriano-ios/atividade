//
//  ContentView.swift
//  PersistenciaDados
//
//  Created by Santos, Adriano da Silva on 18/05/26.
//

import SwiftUI
import CoreData

enum Category: String, CaseIterable, Identifiable {
    case Energia, Internet, Agua = "Água", Assinaturas, Aluguel, Mercado, Cursos, Lazer
    var id: String { rawValue }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showAdd = false

    let months = ["Janeiro","Fevereiro","Março","Abril","Maio"]

    var body: some View {
        NavigationStack {
            List {
                ForEach(1...5, id: \.self) { m in
                    NavigationLink(destination: MonthListView(monthIndex: Int16(m))) {
                        HStack {
                            Text(months[m-1])
                            Spacer()
                            MonthTotalView(month: Int16(m)).environment(\.managedObjectContext, viewContext)
                        }
                    }
                }
            }
            .navigationTitle("Despesas (Jan-Mai)")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showAdd.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddExpenseView().environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

struct MonthTotalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var expenses: FetchedResults<Expense>

    init(month: Int16) {
        _expenses = FetchRequest(fetchRequest: Expense.fetchRequestForMonth(month))
    }

    var total: Double { expenses.reduce(0) { $0 + $1.amount } }

    var body: some View {
        Text("R$ \(total, specifier: "%.2f")")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}
 
