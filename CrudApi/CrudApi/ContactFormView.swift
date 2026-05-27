//
//  ContactFormView.swift
//  CrudApi
//
//  Created by Santos, Adriano da Silva on 25/05/26.
//

import SwiftUI

struct ContactFormView: View {
    @ObservedObject var vm: ContactViewModel
    @Binding var contatoEdit: Contact?
    @Environment(\.dismiss) private var dismiss
    
    var onSaved: (() -> Void)? = nil
    
    @State private var contato: Contact = Contact()
    @State private var isSaving = false
    @State private var cepSearching = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Identificação") {
                    TextField("Nome", text: $contato.nome)
                    TextField("E-mail", text: $contato.email)
                        .keyboardType(.emailAddress)
                    TextField("Telefone", text: $contato.telefone)
                        .keyboardType(.phonePad)
                    TextField("Nascimento (dd/MM/yyyy)", text: $contato.nascimento)
                }
                
                Section("Endereço") {
                    HStack {
                        TextField("CEP", text: $contato.cep)
                            .keyboardType(.numberPad)
                        Button("Buscar") {
                            cepSearching = true
                            vm.lookupCEP(contato.cep) { uf, cidade, bairro, logradouro in
                                cepSearching = false
                                if let uf = uf {
                                    contato.estado = uf
                                    contato.cidade = cidade ?? ""
                                    contato.bairro = bairro ?? ""
                                    contato.logradouro = logradouro ?? ""
                                }
                            }
                        }
                        .disabled(contato.cep.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                    if cepSearching { ProgressView().scaleEffect(0.8) }
                    TextField("Logradouro", text: $contato.logradouro)
                    TextField("Número", text: $contato.numero)
                    TextField("Bairro", text: $contato.bairro)
                    TextField("Cidade", text: $contato.cidade)
                    TextField("Estado", text: $contato.estado)
                }
            }
            .navigationTitle(contatoEdit == nil ? "Novo Contato" : "Editar Contato")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(isSaving ? "Salvando..." : "Salvar") {
                        isSaving = true
                        if let _ = contato.codigo {
                            vm.updateContato(contato)
                        } else {
                            vm.addContato(contato)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            isSaving = false
                            vm.fetchContatos()
                            // notificar o chamador (ex.: detalhe) para que ele possa dar pop
                            onSaved?()
                            dismiss()
                        }
                    }
                    .disabled(contato.nome.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .onAppear {
                if let edit = contatoEdit {
                    contato = edit
                } else {
                    contato = Contact()
                }
            }
        }
    }
}
