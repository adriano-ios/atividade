//
//  ContactViewModel.swift
//  CrudApi
//
//  Created by Santos, Adriano da Silva on 25/05/26.
//

import Foundation
import Combine

class ContactViewModel: ObservableObject {
    @Published var contatos: [Contact] = []
    @Published var errorText: String = ""

    private let urlBase = URL(string: "http://localhost:3000/")!
    private var cancellables = Set<AnyCancellable>()

    // GET /listar
    func fetchContatos() {
        let url = urlBase.appendingPathComponent("listar")
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Contact].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(err) = completion {
                    self.errorText = err.localizedDescription
                }
            } receiveValue: { contatos in
                self.contatos = contatos
            }
            .store(in: &cancellables)
    }

    // POST /cadastrar
    func addContato(_ contato: Contact) {
        let url = urlBase.appendingPathComponent("cadastrar")
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONEncoder().encode(contato)

        URLSession.shared.dataTask(with: req) { data, _, error in
            if let error = error {
                DispatchQueue.main.async { self.errorText = error.localizedDescription }
                return
            }
            // Recarrega lista (ou decodifica a resposta para adicionar localmente)
            DispatchQueue.main.async { self.fetchContatos() }
        }.resume()
    }

    // PUT /alterar/:codigo
    func updateContato(_ contato: Contact) {
        guard let codigo = contato.codigo else { return }
        let url = urlBase.appendingPathComponent("alterar").appendingPathComponent(String(codigo))
        var req = URLRequest(url: url)
        req.httpMethod = "PUT"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONEncoder().encode(contato)

        URLSession.shared.dataTask(with: req) { _, _, error in
            if let error = error {
                DispatchQueue.main.async { self.errorText = error.localizedDescription }
                return
            }
            DispatchQueue.main.async { self.fetchContatos() }
        }.resume()
    }

    // DELETE /remover/:codigo
    func deleteContato(codigo: Int) {
        let url = urlBase.appendingPathComponent("remover").appendingPathComponent(String(codigo))
        var req = URLRequest(url: url)
        req.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: req) { _, _, error in
            if let error = error {
                DispatchQueue.main.async { self.errorText = error.localizedDescription }
                return
            }
            DispatchQueue.main.async { self.fetchContatos() }
        }.resume()
    }
    
    func lookupCEP(_ cepRaw: String, completion: @escaping (String?, String?, String?, String?) -> Void) {
        let cep = cepRaw.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        guard cep.count == 8 else {
            completion(nil, nil, nil, nil)
            return
        }

        let url = urlBase.appendingPathComponent("cep").appendingPathComponent(cep) // ou ViaCEP direto

        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                DispatchQueue.main.async { completion(nil, nil, nil, nil) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion(nil, nil, nil, nil) }
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let erro = json["erro"] as? Bool, erro == true {
                        DispatchQueue.main.async { completion(nil, nil, nil, nil) }
                        return
                    }
                    let uf = json["uf"] as? String
                    let localidade = json["localidade"] as? String
                    let bairro = json["bairro"] as? String
                    let logradouro = json["logradouro"] as? String
                    DispatchQueue.main.async {
                        completion(uf, localidade, bairro, logradouro)
                    }
                    return
                } else {
                    DispatchQueue.main.async { completion(nil, nil, nil, nil) }
                }
            } catch {
                DispatchQueue.main.async { completion(nil, nil, nil, nil) }
            }
        }.resume()
    }

    
}
 
