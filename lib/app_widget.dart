import 'package:clean_arch_dart_poc/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
      title: 'Clean Arch POC',
      theme: theme,
    );
  }
}
