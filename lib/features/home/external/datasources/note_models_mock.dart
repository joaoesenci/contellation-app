import 'dart:math';

import 'package:constellation_app/core/infra/models/note_model.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';

final class NoteModelsMock {
  static List<NoteModel> models = List.generate(25, (index) {
    final ids = [
      AppStrings.deepFocusId,
      AppStrings.quietMomentsId,
      AppStrings.tomorrowsOrbitId,
    ];

    final titles = [
      'Ideia para o projeto X',
      'Comprar café',
      'Ligar para a mãe',
      'Estudar Flutter Bloc',
      'Revisar arquitetura Clean',
      'Agendar dentista',
      'Escrever diário',
      'Planejar viagem',
      'Ver documentação',
      'Terminar o relatório',
      'Comprar presente',
      'Leitura do livro',
      'Bebi um chá hoje',
      'Comprar leite',
      'Treino de perna',
      'Meditação matinal',
      'Email para cliente',
      'Revisão de código',
      'Aniversário da Ana',
      'Limpar aquário',
      'Comprar ração',
      'Configurar servidor',
      'Estudar Design Pattern',
      'Comprar baterias',
      'Reunião de alinhamento',
    ];

    final texts = [
      'Preciso focar na implementação do novo componente.',
      'O café acabou, comprar da marca especial.',
      'Faz tempo que não converso com ela.',
      'Aprofundar nos conceitos de estados e eventos.',
      'Garantir que as camadas estejam bem isoladas.',
      'Ligar logo cedo para marcar horário.',
      'Hoje o dia foi produtivo e cheio de desafios.',
      'Escolher o destino para as próximas férias.',
      'Ler sobre as novidades do Dart 3.x.',
      'O prazo final é sexta-feira à tarde.',
      'Lembrar de embrulhar antes de entregar.',
      'Li o capítulo 3, é bem interessante.',
      'Um chá preto quente cai muito bem.',
      'Não esquecer de pegar o integral.',
      'Foco total na execução dos exercícios.',
      '10 minutos de silêncio para começar bem.',
      'Responder sobre as alterações solicitadas.',
      'Verificar se há erros nos logs.',
      'Não esquecer de comprar o cartão.',
      'Limpar os filtros e trocar a água.',
      'A gata está quase sem comida.',
      'O deploy no ambiente de teste falhou.',
      'Aplicar Observer para desacoplar as camadas.',
      'Precisamos de pilhas novas para o controle.',
      'Reunir a equipe para discutir a Sprint.',
    ];

    final String? constellationId = index < 3 ? null : ids[index % ids.length];

    final int starVariant = index < 3 ? 5 : Random().nextInt(4) + 1;

    return NoteModel(
      id: (index + 1).toString(),
      constellationId: constellationId,
      title: titles[index],
      text: texts[index],
      date: DateTime.now().subtract(Duration(days: index)),
      starVariant: starVariant,
      positionX: index.toDouble(),
      positionY: index.toDouble(),
    );
  });
}
