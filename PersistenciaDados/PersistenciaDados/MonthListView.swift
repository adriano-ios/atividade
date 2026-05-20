//
//  MonthListView.swift
//  PersistenciaDados
//
//  Created by Santos, Adriano da Silva on 18/05/26.
//

import SwiftUI
import CoreData

struct MonthListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let monthIndex: Int16

    @FetchRequest var expenses: FetchedResults<Expense>

    init(monthIndex: Int16) {
        self.monthIndex = monthIndex
        _expenses = FetchRequest(fetchRequest: Expense.fetchRequestForMonth(monthIndex))
    }

    var body: some View {
        List {
            ForEach(expenses, id: \.id) { e in
                HStack {
                    VStack(alignment: .leading) {
                        Text(e.category)
                        if let note = e.note { Text(note).font(.caption).foregroundColor(.secondary) }
                    }
                    Spacer()
                    Text("R$ \(e.amount, specifier: "%.2f")")
                }
            }
            .onDelete(perform: delete)
        }
        .navigationTitle(monthTitle())
    }

    private func monthTitle() -> String {
        switch monthIndex {
        case 1: return "Janeiro"
        case 2: return "Fevereiro"
        case 3: return "Março"
        case 4: return "Abril"
        case 5: return "Maio"
        default: return "Mês"
        }
    }

    private func delete(at offsets: IndexSet) {
        for i in offsets { viewContext.delete(expenses[i]) }
        try? viewContext.save()
    }
}
 
