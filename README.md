# ✦ Constellation

Aplicação mobile desenvolvida com Flutter para registrar e organizar pensamentos rápidos em um universo visual de constelações.

A proposta do Constellation é transformar pensamentos "soltos" em pequenas estrelas que podem ser organizadas visualmente dentro de constelações, criando uma experiência de registro mais leve, visual e intuitiva.

> **Nota:** A parte em específico do canvas contendo as estrelas e constelações ainda não está finalizada.


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


## 📸 Screenshots

<img width="421" height="880" alt="image" src="https://github.com/user-attachments/assets/a9f68428-70fc-40a5-a614-771d611d64b3" /> <img width="411" height="873" alt="image" src="https://github.com/user-attachments/assets/79574e7d-2432-4b7a-82e7-b551df880870" />

<img width="421" height="879" alt="image" src="https://github.com/user-attachments/assets/683dd5f9-2f3f-46d7-a556-1f0cd963eae0" /> <img width="411" height="868" alt="image" src="https://github.com/user-attachments/assets/304ab115-d03e-4b38-8062-a31d233b9835" />

<img width="410" height="869" alt="image" src="https://github.com/user-attachments/assets/f0444617-b474-4097-a5cd-30423e6bbd77" /> <img width="421" height="876" alt="image" src="https://github.com/user-attachments/assets/7618f3d8-0ef8-46c7-a494-3ab564c23afb" />

<img width="410" height="865" alt="image" src="https://github.com/user-attachments/assets/8ef0ba20-5d1d-4195-a839-b5f2db43a676" />


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
```

## 📫 Contato

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Perfil-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/jo%C3%A3o-eduardo-senci-b85ba8416/)

[![GitHub](https://img.shields.io/badge/GitHub-joaoesenci-black?style=flat&logo=github)](https://github.com/joaoesenci)
