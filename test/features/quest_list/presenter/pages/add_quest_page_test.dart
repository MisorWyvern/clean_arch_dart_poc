import 'package:clean_arch_dart_poc/core/widgets/custom_button.dart';
import 'package:clean_arch_dart_poc/core/widgets/custom_list_tile.dart';
import 'package:clean_arch_dart_poc/core/widgets/custom_text_field.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/pages/add_quest_page.dart';
import 'package:clean_arch_dart_poc/features/quest_list/quest_list_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  initModule(QuestListModule(), initialModule: true);

  testWidgets("Should render all the form and preview",
      (WidgetTester _tester) async {
    await _tester.pumpWidget(buildTestableWidget(AddQuestPage()));

    final nameTextField = find.widgetWithText(CustomTextField, "Name");
    final descriptionTextField =
        find.widgetWithText(CustomTextField, "Description");
    final btnCreate = find.byType(CustomButton);
    final previewTile = find.byType(CustomListTile);

    expect(nameTextField, findsOneWidget);
    expect(descriptionTextField, findsOneWidget);
    expect(btnCreate, findsOneWidget);
    expect(previewTile, findsOneWidget);
  });

  testWidgets("Should not navigate on create button tap with empty text fields",
      (WidgetTester _tester) async {
    await _tester.pumpWidget(buildTestableWidget(AddQuestPage()));

    final nameTextField = find.widgetWithText(CustomTextField, "Name");
    final descriptionTextField =
        find.widgetWithText(CustomTextField, "Description");
    final btnCreate = find.byType(CustomButton);

    await _tester.tap(btnCreate);

    await _tester.enterText(nameTextField, "");
    await _tester.enterText(descriptionTextField, "");
    await _tester.tap(btnCreate);

    final title = find.widgetWithText(AppBar, "Add new DailyQ");
    expect(title, findsOneWidget);
  });
}
