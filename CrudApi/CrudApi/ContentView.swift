//
//  ContentView.swift
//  CrudApi
//
//  Created by Santos, Adriano da Silva on 25/05/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ContactViewModel()
    @State private var showForm = false
    @State private var editing: Contact? = nil

    var body: some View {
        NavigationStack {
            List {
                if vm.contatos.isEmpty {
                    Text("Nenhum contato cadastrado").foregroundColor(.secondary)
                } else {
                    ForEach(vm.contatos) { contato in
                        NavigationLink(value: contato) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(contato.nome).font(.headline)
                                    Text(contato.email).font(.caption).foregroundColor(.secondary)
                                }
                                Spacer()
                                Text(contato.telefone).font(.subheadline)
                            }
                        }
                        .contextMenu {
                            Button("Editar") { editing = contato; showForm = true }
                            if let codigo = contato.codigo {
                                Button("Remover", role: .destructive) { vm.deleteContato(codigo: codigo) }
                            }
                        }
                    }
                    .onDelete { idx in
                        idx.forEach { i in
                            if let codigo = vm.contatos[i].codigo {
                                vm.deleteContato(codigo: codigo)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Contatos")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { editing = nil; showForm = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: Contact.self) { contato in
                ContactDetailView(contato: contato, vm: vm)
            }
            .onAppear { vm.fetchContatos() }
            .sheet(isPresented: $showForm) {
                ContactFormView(vm: vm, contatoEdit: $editing)
            }
        }
    }
}
