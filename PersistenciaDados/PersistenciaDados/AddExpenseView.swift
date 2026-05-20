//
//  AddExpenseView.swift
//  PersistenciaDados
//
//  Created by Santos, Adriano da Silva on 18/05/26.
//

import SwiftUI
import CoreData

struct AddExpenseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var selectedCategory: Category = .Energia
    @State private var amountText: String = ""
    @State private var selectedMonth: Int = 1
    @State private var note: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Picker("Categoria", selection: $selectedCategory) {
                    ForEach(Category.allCases) { c in Text(c.rawValue).tag(c) }
                }
                TextField("Valor (ex: 123.45)", text: $amountText)
                    .keyboardType(.decimalPad)
                Picker("Mês", selection: $selectedMonth) {
                    ForEach(1...5, id: \.self) { m in Text(monthName(m)).tag(m) }
                }
                TextField("Observação", text: $note)
            }
            .navigationTitle("Adicionar Despesa")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") { salvar() }
                        .disabled(Double(amountText.replacingOccurrences(of: ",", with: ".")) == nil)
                }
            }
        }
    }

    private func salvar() {
        guard let valor = Double(amountText.replacingOccurrences(of: ",", with: ".")) else { return }
        let e = Expense(context: viewContext)
        e.id = UUID()
        e.category = selectedCategory.rawValue
        e.amount = valor
        e.month = Int16(selectedMonth)
        e.note = note.isEmpty ? nil : note
        e.date = Date()
        do { try viewContext.save(); dismiss() } catch { print("Erro salvar: \(error)") }
    }

    private func monthName(_ m: Int) -> String {
        ["Jan","Fev","Mar","Abr","Mai"][m-1]
    }
}
 
