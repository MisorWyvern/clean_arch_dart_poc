import 'package:clean_arch_dart_poc/core/theme/theme.dart';
import 'package:clean_arch_dart_poc/features/splash_screen/presenter/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/spy_splash_screen_module.dart';

main() {
  initModule(
    SpySplashScreenModule(),
    initialModule: true,
  );

  testWidgets("Golden Test", (WidgetTester _tester) async {
    await _tester.pumpWidget(buildTestableWidget(
      MaterialApp(
        home: SplashScreenPage(),
        theme: theme,
      ),
    ));

    await expectLater(find.byType(SplashScreenPage),
        matchesGoldenFile("splash_screen_page.png"));
  });

  testWidgets("Should render title and logo on splashscreen",
      (WidgetTester _tester) async {
    await _tester.pumpWidget(buildTestableWidget(
      MaterialApp(
        home: SplashScreenPage(),
        theme: theme,
      ),
    ));

    final mainTitle = find.text("DailyQs");
    final mainLogo = find.byType(Image);

    expect(mainTitle, findsOneWidget);
    expect(mainLogo, findsOneWidget);
  });
}
