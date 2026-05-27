//
//  Contact.swift
//  CrudApi
//
//  Created by Santos, Adriano da Silva on 25/05/26.
//

import Foundation

struct Contact: Identifiable, Codable, Equatable, Hashable {
    var id: Int? { codigo }
    var codigo: Int?
    var nome: String
    var email: String
    var telefone: String
    var nascimento: String
    var cep: String
    var bairro: String
    var logradouro: String
    var numero: String
    var estado: String
    var cidade: String

    init(
        codigo: Int? = nil,
        nome: String = "",
        email: String = "",
        telefone: String = "",
        nascimento: String = "",
        cep: String = "",
        bairro: String = "",
        logradouro: String = "",
        numero: String = "",
        estado: String = "",
        cidade: String = ""
    ) {
        self.codigo = codigo
        self.nome = nome
        self.email = email
        self.telefone = telefone
        self.nascimento = nascimento
        self.cep = cep
        self.bairro = bairro
        self.logradouro = logradouro
        self.numero = numero
        self.estado = estado
        self.cidade = cidade
    }
}
