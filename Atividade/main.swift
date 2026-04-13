//
//  main.swift
//  Atividade
//
//  Created by Santos, Adriano da Silva on 09/04/26.
//
//  Cadastro de contatos

import Foundation

print("Olá! Bem vindo ao cadastro de contatos!")
print()

var encerrarCadastroContato = false
var id = 1

protocol Contato {
    var id: Int { get }
    var nome: String { get }
    var idade: String { get }
    var telefone: String { get }
    var email: String { get }
}

struct ContatoFavorito: Contato {
    private(set) var id: Int
    private(set) var nome: String
    private(set) var idade: String
    private(set) var telefone: String
    private(set) var email: String
    
}

struct ContatoCRUD<T: Contato> {
    private var lista: [T] = []

    mutating func cadastrar(contato: T)  -> Void {
        lista.append(contato)
        print("✅ Contato cadastrado: \(contato.nome)")
        print()
    }

    func listar() -> [T] {
        return lista
    }
    
    mutating func alterar(id: Int, novoContato: T)  -> Void {
        if let index = lista.firstIndex(where: { $0.id == id }) {
            lista[index] = novoContato
            print("✏️ Contato alterado com sucesso!")
            print()
        } else {
            print("❌ Contato não encontrada.")
            print()
        }
    }
    
    mutating func remover(id: Int) -> Void {
        lista.removeAll { $0.id == id }
        print()
        print("🗑️ Contato removido.")
        print()
    }

}

var contatosFavoritos = ContatoCRUD<ContatoFavorito>()

while !encerrarCadastroContato {
    
    print("O que você gostaria de fazer?")
    print()
    print("Para adicionar contato tecle 1")
    print("Para Listar os contatos tecle 2")
    print("Para sair tecle 3")
    print()
    
    if let escolha = readLine() {
        switch escolha {
        case "1":
            print()
            print("Informe seu nome:")
            let nome: String? = readLine()
            
            if (nome ?? "").isEmpty {
                print("O nome deve ser prenchido! O sistema sera reiniciado e voce pode tentar novamente")
                print()
                break
            }
            
            print("Informe sua idade:")
            let idade: String? = readLine()
            
            if (idade ?? "").isEmpty {
                print("A idade deve ser prenchida! O sistema sera reiniciado e voce pode tentar novamente")
                print()
                break
            }

            
            print("Informe seu telefone:")
            let telefone: String? = readLine()
            
            if (telefone ?? "").isEmpty {
                print("O telefone deve ser prenchido! O sistema sera reiniciado e voce pode tentar novamente")
                print()
                break
            }
            
            print("Informe seu email:")
            let email: String? = readLine()

            if (email ?? "").isEmpty {
                print("O email deve ser prenchido! O sistema sera reiniciado e voce pode tentar novamente")
                print()
                break
            }
            
            let contatoFavorito = ContatoFavorito(id: id, nome: nome!, idade: idade!, telefone: telefone!, email: email!)
            
            if contatosFavoritos.listar().first(where: { $0.nome == nome }) != nil{
                print()
                print("Contato já cadastrado ❌! Voce será redirecionado para o menu de cadastro")
                print()
            } else {
                contatosFavoritos.cadastrar(contato: contatoFavorito)
                id += 1
            }
            
            
        case "2":
            print()
            print("********** Listando contatos **********")
            print()
            
            contatosFavoritos.listar().forEach {
              print($0.nome)
            }
            
            print()
            print("Deseja alterar ✏️ algum contato? Se sim informe o A")
            print("Deseja remover 🗑️ algum contato? Se sim informe o R")
            print()
            
            let opcao: String? = readLine()
            
            if opcao == "A" {
                
                print()
                print("Ok, agora informe o ID do contato que deseja alterar ✏️")
                print()
                let atualizaId = Int(readLine() ?? "ID invalido")
                
                if contatosFavoritos.listar().firstIndex(where: { $0.id == atualizaId}) != nil {
                    
                    print()
                    print("Atualizar o nome do contato atual? Informe o novo nome:")
                    let nomeAtualizado: String? = readLine()
                    
                    if (nomeAtualizado ?? "").isEmpty {
                        print("O nome deve ser prenchido! O sistema sera reiniciado e voce pode tentar novamente")
                        print()
                        break
                    }
                    
                    print("Atualizar a idade do contato, informe a idade")
                    let idadeAtualizada: String? = readLine()
                    
                    if (idadeAtualizada ?? "").isEmpty {
                        print("A idade deve ser prenchida! O sistema sera reiniciado e voce pode tentar novamente")
                        print()
                        break
                    }
                    
                    print("Atualizar o telefone do contato, informe o telefone:")
                    let telefoneAtualizado: String? = readLine()
                    
                    if (telefoneAtualizado ?? "").isEmpty {
                        print("O telefone deve ser prenchido! O sistema sera reiniciado e voce pode tentar novamente")
                        print()
                        break
                    }
                    
                    print("Atualizar o email do contato, informe o email:")
                    let emailAtualizado: String? = readLine()
                    
                    if (nomeAtualizado ?? "").isEmpty {
                        print("O email deve ser prenchido! O sistema sera reiniciado e voce pode tentar novamente")
                        print()
                        break
                    }
                    
                    let cfAtualizado = ContatoFavorito(id: atualizaId!, nome: nomeAtualizado!, idade: idadeAtualizada!, telefone: telefoneAtualizado!, email: emailAtualizado!)
                    
                    
                    contatosFavoritos.alterar(id: atualizaId!, novoContato: cfAtualizado)
                    
                }else {
                    print()
                    print("ID inválido, voce sera redirecionado para o menu inicial")
                    print()
                }
                    
            } else if opcao == "R" {
                    
                    print()
                    print("Ok, agora informe o ID do contato que deseja remover 🗑️ ")
                    print()
                    let atualizaId = Int(readLine() ?? "ID invalido")
                    
                    if contatosFavoritos.listar().firstIndex(where: { $0.id == atualizaId}) != nil {
                    
                        contatosFavoritos.remover(id: atualizaId!)
                        
                    }else {
                        print()
                        print("ID inválido, voce sera redirecionado para o menu inicial")
                        print()
                    }
                    
            } else {
                    
                print()
                print("Opcao inválida, voce sera redirecionado para o menu inicial")
                print()
            }
            
            
            

        case "3":
            print("Cadastro de contatos encerrado!")
            encerrarCadastroContato = true
        default:
            print()
            print("⚠️ Opção não encontrada, tente novamente!")
            print()
            break
        }
    }
}







