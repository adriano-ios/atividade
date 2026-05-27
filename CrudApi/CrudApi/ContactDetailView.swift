import SwiftUI

struct ContactDetailView: View {
    let contato: Contact
    let vm: ContactViewModel
    
    @State private var showEdit = false
    @State private var editing: Contact? = nil
    @Environment(\.dismiss) private var navDismiss

    var body: some View {
        Form {
            Section("Dados") {
                Text(contato.nome).font(.title2)
                Text(contato.email)
                Text(contato.telefone)
                Text("Nascimento: \(contato.nascimento)")
            }
            Section("Endereço") {
                Text("\(contato.logradouro), \(contato.numero)")
                Text("\(contato.bairro) — \(contato.cidade) / \(contato.estado)")
                Text("CEP: \(contato.cep)")
            }
        }
        .navigationTitle("Detalhes")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                    Button("Editar") {
                        editing = contato
                        showEdit = true
                    }
                }
            }
            .sheet(isPresented: $showEdit) {
                // passa closure que fecha a tela de detalhe (pop)
                ContactFormView(vm: vm, contatoEdit: $editing, onSaved: {
                    // após salvar, fechar a tela de detalhes (voltar lista)
                    navDismiss()
                })
            }
    }
}
