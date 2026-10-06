# ✦ Constellation

Aplicação mobile desenvolvida com Flutter para registrar e organizar pensamentos rápidos em um universo visual de constelações.

A proposta do Constellation é transformar pensamentos "soltos" em pequenas estrelas que podem ser organizadas visualmente dentro de constelações, criando uma experiência de registro mais leve, visual e intuitiva.

> **Nota:** A parte em específico do canvas contendo as estrelas e constelações ainda não está finalizada.

---

## ✨ Sobre o projeto

O Constellation nasceu da ideia de criar uma experiência de anotação diferente de aplicativos tradicionais de notas.

Em vez de apresentar os registros apenas como uma lista, cada nota pode ser representada visualmente como uma estrela dentro de uma constelação, além de uma UI de baixo estímulo, ideal para usar em noites/madrugadas.

O projeto foi desenvolvido com foco em:

- Experiência de usuário em primeiro lugar
- Organização visual
- Arquitetura de software
- Separação de responsabilidades
- Persistência local
- Componentização
- Escalabilidade

---

## 🚀 Funcionalidades

- Criação de notas
- Edição de notas
- Exclusão de notas
- Persistência local das notas
- Organização de notas por constelações
- Seleção de constelações
- Visualização das notas em lista
- Visualização das notas em um canvas de constelações
- Pesquisa de notas
- Filtros de constelações
- Contagem de notas selecionadas
- Renderização visual das estrelas
- Layout dinâmico das constelações
- Tela de carregamento e tratamento de estados de erro
- Interface adaptada para orientação portrait

---

## 🛠️ Tecnologias

- Flutter
- Dart
- Clean Architecture
- Bloc / Cubit
- Flutter Modular
- FP Dart
- Equatable
- Hive CE
- Hive CE Flutter
- Path Provider
- CustomPainter
- Flutter SVG
- Phosphor Icons
- Fading Edge ScrollView
- Tipografia personalizada com Inter e Nunito
- Implementação de alguns ícones/imagens externas feitas por um designer
- Git
- FVM

---

## 🏗️ Arquitetura

O projeto utiliza uma organização baseada em princípios de Clean Architecture, buscando manter as responsabilidades separadas entre domínio, infraestrutura, apresentação e recursos compartilhados.

A estrutura principal do projeto é organizada da seguinte forma:

```text
lib/
├── app/
│   ├── app_module.dart
│   ├── app_routes.dart
│   └── app_widget.dart
│
├── core/
│   ├── domain/
│   │   ├── entities/
│   │   ├── failures/
│   │   └── usecases/
│   │
│   ├── infra/
│   │   ├── fixtures/
│   │   └── models/
│   │
│   └── services/
│       ├── constellation_layout/
│       └── storage/
│
├── features/
│   ├── home/
│   │   ├── domain/
│   │   ├── external/
│   │   ├── infra/
│   │   ├── presentation/
│   │   └── cubits/
│   │
│   └── splash/
│
└── shared/
    ├── constants/
    ├── themes/
    ├── utils/
    └── widgets/
