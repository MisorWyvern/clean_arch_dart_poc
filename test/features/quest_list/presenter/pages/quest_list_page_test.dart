import 'package:clean_arch_dart_poc/core/theme/theme.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/controllers/quest_controller.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/pages/quest_list_page.dart';
import 'package:clean_arch_dart_poc/features/quest_list/quest_list_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  initModule(QuestListModule(), initialModule: true);
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
}
