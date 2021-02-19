import 'package:clean_arch_dart_poc/core/theme/theme.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/controllers/quest_controller.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/pages/quest_list_page.dart';
import 'package:clean_arch_dart_poc/features/quest_list/quest_list_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

class SpyQuestListModule extends QuestListModule {
  final prefix = "/questlist";
  @override
  List<ModularRouter> get routers => [
        ModularRouter(prefix + "/addquest", child: (_, __) => Container()),
        // ...super.routers,
      ];

  @override
  List<Bind> get binds => [
        ...super.binds,
      ];
}

main() {
  initModule(SpyQuestListModule(), initialModule: true);
  QuestController _controller;

  setUp(() {
    _controller = Modular.get();
    expect(_controller, isInstanceOf<QuestController>());
  });
  testWidgets("Should render all buttons", (WidgetTester _tester) async {
    await _tester.pumpWidget(buildTestableWidget(
      MaterialApp(
        home: QuestListPage(),
        theme: theme,
      ),
    ));

    final btnHelp = find.widgetWithIcon(IconButton, Icons.help_rounded);
    final btnSettings = find.widgetWithIcon(IconButton, Icons.settings);
    final btnAdd = find.widgetWithIcon(FloatingActionButton, Icons.add);

    expect(btnHelp, findsOneWidget);
    expect(btnSettings, findsOneWidget);
    expect(btnAdd, findsOneWidget);
  });

  testWidgets("Should redirect to AddQuestPage", (WidgetTester _tester) async {
    await _tester.pumpWidget(buildTestableWidget(
      QuestListPage(),
    ));

    final btnAdd = find.widgetWithIcon(FloatingActionButton, Icons.add);

    await _tester.tap(btnAdd);
  });
}
