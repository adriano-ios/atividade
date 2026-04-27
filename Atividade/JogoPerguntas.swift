//
//  Abas.swift
//  UI
//
//  Created by Santos, Adriano da Silva on 23/04/26.
//

import SwiftUI

struct QuizGame: View {

    // Temas e perguntas
    enum Tema: String, CaseIterable, Identifiable {
        var id: String { rawValue }
        case Historia = "História"
        case Fisica = "Física"
        case Geografia = "Geografia"
        case Matematica = "Matemática"

        case Java = "Java"
        case Kotlin = "Kotlin"
        case Python = "Python"
        case Swift = "Swift"

        case Livros = "Livros"
        case Filmes = "Filmes"
        case Series = "Séries"
        case Documentarios = "Documentários"
    }

    struct Pergunta: Identifiable {
        let id = UUID()
        let texto: String
        let opcoes: [String]
        let correta: Int
    }

    // Base de perguntas por tema (5 por tema)
    let banco: [Tema: [Pergunta]] = [
        .Historia: [
            Pergunta(texto: "Quem descobriu o Brasil?", opcoes: ["Pedro Álvares Cabral","Cristóvão Colombo","Vasco da Gama","Fernão de Magalhães"], correta: 0),
            Pergunta(texto: "Em que ano terminou a Segunda Guerra Mundial?", opcoes: ["1943","1944","1945","1946"], correta: 2),
            Pergunta(texto: "Qual foi a civilização que construiu as pirâmides de Gizé?", opcoes: ["Romanos","Gregos","Egípcios","Hititas"], correta: 2),
            Pergunta(texto: "Quem foi o líder da Revolução Russa de 1917?", opcoes: ["Lenin","Stalin","Trotsky","Kerensky"], correta: 0),
            Pergunta(texto: "Qual era o sistema político da Idade Média europeia?", opcoes: ["Capitalismo","Feudalismo","Comunismo","Imperialismo"], correta: 1)
        ],
        .Fisica: [
            Pergunta(texto: "Qual é a unidade SI da força?", opcoes: ["Joule","Newton","Watt","Pascal"], correta: 1),
            Pergunta(texto: "Velocidade da luz no vácuo (aprox.) em m/s?", opcoes: ["3×10^6","3×10^7","3×10^8","3×10^9"], correta: 2),
            Pergunta(texto: "Quem formulou as leis do movimento clássico?", opcoes: ["Einstein","Newton","Galileu","Maxwell"], correta: 1),
            Pergunta(texto: "Qual fenômeno explica o desvio aparente do som?", opcoes: ["Interferência","Efeito Doppler","Difração","Refração"], correta: 1),
            Pergunta(texto: "Unidade de carga elétrica no SI?", opcoes: ["Volt","Ampere","Coulomb","Ohm"], correta: 2)
        ],
        .Geografia: [
            Pergunta(texto: "Qual o maior país em área?", opcoes: ["Canadá","Rússia","China","Estados Unidos"], correta: 1),
            Pergunta(texto: "Qual o rio mais longo do mundo (conflito existe) frequentemente citado?", opcoes: ["Nilo","Amazônas","Yangtzé","Mississippi"], correta: 0),
            Pergunta(texto: "Qual é a capital do Japão?", opcoes: ["Osaka","Tóquio","Kyoto","Nagoya"], correta: 1),
            Pergunta(texto: "Continente com maior número de países?", opcoes: ["África","Ásia","Europa","América"], correta: 0),
            Pergunta(texto: "Qual oceano banha a costa leste dos EUA?", opcoes: ["Pacífico","Índico","Atlântico","Ártico"], correta: 2)
        ],
        .Matematica: [
            Pergunta(texto: "Quanto é 7×8?", opcoes: ["54","56","58","60"], correta: 1),
            Pergunta(texto: "Qual é a raiz quadrada de 81?", opcoes: ["7","8","9","10"], correta: 2),
            Pergunta(texto: "Qual o valor de π aproximado?", opcoes: ["2.14","3.14","1.41","4.13"], correta: 1),
            Pergunta(texto: "Qual é o menor número primo?", opcoes: ["0","1","2","3"], correta: 2),
            Pergunta(texto: "Qual operação é a inversa da multiplicação?", opcoes: ["Soma","Subtração","Divisão","Exponenciação"], correta: 2)
        ],
        .Java: [
            Pergunta(texto: "Qual palavra-chave declara uma classe em Java?", opcoes: ["struct","class","module","object"], correta: 1),
            Pergunta(texto: "Qual é o método principal de entrada em Java?", opcoes: ["start()","main()","run()","init()"], correta: 1),
            Pergunta(texto: "Qual empresa originalmente criou o Java?", opcoes: ["Microsoft","Sun Microsystems","Apple","IBM"], correta: 1),
            Pergunta(texto: "Qual extensão de arquivo é usado para código fonte Java?", opcoes: [".jav",".java",".jv",".jss"], correta: 1),
            Pergunta(texto: "Qual palavra-chave evita que uma subclasse sobrescreva um método?", opcoes: ["static","final","override","sealed"], correta: 1)
        ],
        .Kotlin: [
            Pergunta(texto: "Kotlin é interoperável com qual linguagem JVM?", opcoes: ["Scala","Java","Groovy","Clojure"], correta: 1),
            Pergunta(texto: "Como declara-se uma função em Kotlin?", opcoes: ["def fun()","func()","fun nome()","function nome()"], correta: 2),
            Pergunta(texto: "Qual empresa mantém Kotlin?", opcoes: ["Apple","JetBrains","Google","Microsoft"], correta: 1),
            Pergunta(texto: "Kotlin suporta inferência de tipo?", opcoes: ["Não","Sim com var/val","Só para var","Só para val"], correta: 1),
            Pergunta(texto: "Qual palavra reserva cria uma variável imutável?", opcoes: ["let","const","val","final"], correta: 2)
        ],
        .Python: [
            Pergunta(texto: "Qual símbolo inicia um comentário em Python?", opcoes: ["//","#","/*","<!--"], correta: 1),
            Pergunta(texto: "Qual função imprime na tela em Python 3?", opcoes: ["echo()","printf()","print()","println()"], correta: 2),
            Pergunta(texto: "Qual palavra-chave define uma função em Python?", opcoes: ["function","def","fun","fn"], correta: 1),
            Pergunta(texto: "Qual é a extensão padrão de arquivos Python?", opcoes: [".pt",".py",".p",".pyc"], correta: 1),
            Pergunta(texto: "Qual estrutura é mutável e ordenada em Python?", opcoes: ["tuple","list","set","frozenset"], correta: 1)
        ],
        .Swift: [
            Pergunta(texto: "Qual palavra-chave declara uma constante em Swift?", opcoes: ["let","const","var","final"], correta: 0),
            Pergunta(texto: "Qual framework UI é usado aqui no projeto?", opcoes: ["UIKit","AppKit","SwiftUI","React Native"], correta: 2),
            Pergunta(texto: "Qual operador concatena strings em Swift?", opcoes: ["+","&","||","++"], correta: 0),
            Pergunta(texto: "Qual é a sintaxe para interpolação de strings?", opcoes: ["\\(x)","${x}","{x}","%x"], correta: 0),
            Pergunta(texto: "Qual palavra-chave declara uma variável mutável?", opcoes: ["let","var","mut","set"], correta: 1)
        ],
        .Livros: [
            Pergunta(texto: "Quem escreveu 'Dom Casmurro'?", opcoes: ["Machado de Assis","Jorge Amado","Carlos Drummond","Clarice Lispector"], correta: 0),
            Pergunta(texto: "Gênero literário de '1984' de Orwell?", opcoes: ["Romance Histórico","Distopia","Fantasia","Biografia"], correta: 1),
            Pergunta(texto: "Autor de 'O Pequeno Príncipe'?", opcoes: ["Antoine de Saint-Exupéry","Victor Hugo","J.K. Rowling","Paulo Coelho"], correta: 0),
            Pergunta(texto: "Qual é o formato físico padrão de um livro impresso?", opcoes: ["EPUB","PDF","Impressão","MP3"], correta: 2),
            Pergunta(texto: "Livro famoso escrito por Gabriel García Márquez?", opcoes: ["Cem Anos de Solidão","O Alquimista","Grande Sertão: Veredas","Memórias Póstumas"], correta: 0)
        ],
        .Filmes: [
            Pergunta(texto: "Quem dirigiu 'E.T.'?", opcoes: ["George Lucas","Steven Spielberg","James Cameron","Christopher Nolan"], correta: 1),
            Pergunta(texto: "Filme vencedor de Melhor Filme em 1994 (Oscar)?", opcoes: ["Pulp Fiction","Forrest Gump","Shawshank","Quatro Casamentos"], correta: 1),
            Pergunta(texto: "Qual país produz maior parte dos filmes de Bollywood?", opcoes: ["China","Índia","Estados Unidos","França"], correta: 1),
            Pergunta(texto: "Formato comum de mídia digital de vídeo?", opcoes: ["MP3","MP4","JPG","PNG"], correta: 1),
            Pergunta(texto: "Diretor de 'Inception'?", opcoes: ["Nolan","Scorsese","Tarantino","Kubrick"], correta: 0)
        ],
        .Series: [
            Pergunta(texto: "Série conhecida por 'Winter is Coming'?", opcoes: ["The Witcher","Game of Thrones","Vikings","Westworld"], correta: 1),
            Pergunta(texto: "Plataforma que lançou 'Stranger Things'?", opcoes: ["HBO","Netflix","Amazon Prime","Disney+"], correta: 1),
            Pergunta(texto: "Série com protagonistas detetives em 'True Detective' é anthologia?", opcoes: ["Sim","Não","Só primeira temporada","Só terceira temporada"], correta: 0),
            Pergunta(texto: "Formato típico de temporada de séries americanas?", opcoes: ["10-13 episódios","50-60 episódios","2-4 episódios","100 episódios"], correta: 0),
            Pergunta(texto: "Série baseada nos livros de 'George R.R. Martin'?", opcoes: ["The Expanse","Game of Thrones","House of Cards","Lost"], correta: 1)
        ],
        .Documentarios: [
            Pergunta(texto: "Documentário 'Uma Verdade Inconveniente' trata de qual tema?", opcoes: ["Economia","Meio Ambiente","Esportes","Política"], correta: 1),
            Pergunta(texto: "Formato comum de documentário longa-metragem?", opcoes: ["30 min","60 min","90+ min","10 min"], correta: 2),
            Pergunta(texto: "Documentários geralmente buscam:", opcoes: ["Entreter apenas","Informar e educar","Fazer ficção","Criar jogos"], correta: 1),
            Pergunta(texto: "Plataforma popular para documentários independentes?", opcoes: ["Vimeo","iTunes","Spotify","SoundCloud"], correta: 0),
            Pergunta(texto: "Documentário 'March of the Penguins' foca em qual animal?", opcoes: ["Baleias","Pinguins","Elefantes","Tubarões"], correta: 1)
        ]
    ]

    // divide temas em páginas de 4
    private var temaPages: [[Tema]] {
        let cases = Tema.allCases
        var pages: [[Tema]] = []
        var i = 0
        while i < cases.count {
            let end = min(i + 4, cases.count)
            pages.append(Array(cases[i..<end]))
            i += 4
        }
        return pages
    }

    // Estado do jogo
    @State private var temaSelecionado: Tema? = nil
    @State private var perguntas: [Pergunta] = []
    @State private var indiceAtual: Int = 0
    @State private var selecionada: Int? = nil
    @State private var mostrarFeedback: Bool = false
    @State private var acertos: Int = 0
    @State private var encerrado: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            if temaSelecionado == nil {
                VStack(spacing: 12) {
                    Text("Quiz").font(.largeTitle).bold()
                    Text("Selecione um tema").font(.title3).foregroundColor(.gray)
                }.padding(.top, 8)

                // TabView em páginas de 4 temas
                TabView {
                    ForEach(temaPages.indices, id: \.self) { pageIndex in
                        let page = temaPages[pageIndex]
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(page) { tema in
                                Button {
                                    iniciar(tema: tema)
                                } label: {
                                    CardView {
                                        HStack {
                                            Text(tema.rawValue).font(.headline)
                                            Spacer()
                                        }.padding()
                                    }
                                }
                                .frame(minHeight: 64)
                            }
                            if page.count < 4 {
                                ForEach(0..<(4 - page.count), id: \.self) { _ in
                                    Color.clear.frame(height: 64)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .frame(height: 500)
                .padding(.bottom)

            } else if encerrado {
                CardView {
                    VStack(spacing: 12) {
                        Text("Resultado").font(.title2).bold()
                        Text("Acertos: \(acertos)").foregroundColor(.green)
                        Text("Erros: \(5 - acertos)").foregroundColor(.red)
                        Button("Reiniciar") {
                            reiniciar()
                        }.padding(.top, 8)
                    }.padding()
                }
            } else {
                let p = perguntas[indiceAtual]
                VStack(spacing: 12) {
                    Text("Tema: \(temaSelecionado!.rawValue)").font(.subheadline).foregroundColor(.gray)
                    PerguntaCard(pergunta: p,
                                 selecionada: selecionada,
                                 mostrarFeedback: mostrarFeedback,
                                 onSelect: responder)
                    if mostrarFeedback {
                        Text(respostaTexto(pergunta: p))
                            .foregroundColor(mostrarFeedbackCor(pergunta: p))
                            .padding(.top, 6)
                        Button(indiceAtual == perguntas.count - 1 ? "Ver resultado" : "Próxima") {
                            proxima()
                        }.padding(.top, 8)
                    }
                }.padding()
            }
            Spacer()
        }
        .padding()
    }

    // Ações
    private func iniciar(tema: Tema) {
        temaSelecionado = tema
        perguntas = banco[tema]?.shuffled().prefix(5).map { $0 } ?? []
        indiceAtual = 0
        selecionada = nil
        mostrarFeedback = false
        acertos = 0
        encerrado = false
    }

    private func responder(indice: Int) {
        guard !mostrarFeedback else { return }
        selecionada = indice
        mostrarFeedback = true
        let atual = perguntas[indiceAtual]
        if indice == atual.correta {
            acertos += 1
        }
    }

    private func proxima() {
        selecionada = nil
        mostrarFeedback = false
        if indiceAtual < perguntas.count - 1 {
            indiceAtual += 1
        } else {
            encerrado = true
        }
    }

    private func reiniciar() {
        temaSelecionado = nil
        perguntas = []
        indiceAtual = 0
        selecionada = nil
        mostrarFeedback = false
        acertos = 0
        encerrado = false
    }

    private func respostaTexto(pergunta: Pergunta) -> String {
        if selecionada == pergunta.correta {
            return "Correta!"
        } else {
            return "Incorreta. Resposta correta: \(pergunta.opcoes[pergunta.correta])"
        }
    }

    private func mostrarFeedbackCor(pergunta: Pergunta) -> Color {
        selecionada == pergunta.correta ? .green : .red
    }
}

// Estrutura reutilizável: cartão base para reaproveitar em UI
struct CardView<Content: View>: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) { self.content = content }
    var body: some View {
        VStack { content() }
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemBackground)).shadow(radius: 4))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.15)))
    }
}

// Componente reutilizável para renderizar uma pergunta com opções
struct PerguntaCard: View {
    let pergunta: QuizGame.Pergunta
    let selecionada: Int?
    let mostrarFeedback: Bool
    let onSelect: (Int) -> Void

    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 12) {
                Text(pergunta.texto).font(.headline)
                ForEach(pergunta.opcoes.indices, id: \.self) { idx in
                    Button {
                        onSelect(idx)
                    } label: {
                        HStack {
                            Text(pergunta.opcoes[idx])
                                .foregroundColor(.primary)
                            Spacer()
                            if mostrarFeedback {
                                if idx == pergunta.correta {
                                    Text("✓").foregroundColor(.green)
                                } else if idx == selecionada {
                                    Text("✗").foregroundColor(.red)
                                }
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(corFundo(idx)))
                    }
                    .disabled(mostrarFeedback)
                }
            }.padding()
        }
    }

    private func corFundo(_ idx: Int) -> Color {
        guard mostrarFeedback else { return Color(UIColor.secondarySystemBackground) }
        if idx == pergunta.correta { return Color.green.opacity(0.2) }
        if idx == selecionada { return Color.red.opacity(0.2) }
        return Color(UIColor.secondarySystemBackground)
    }
}

#Preview {
    QuizGame()
}
