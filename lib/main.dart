import 'package:flutter/material.dart';

import 'layers/presenter/UI/pages/splash_screen_page.dart';

void main() {
  runApp(CleanPOC());
}

class CleanPOC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Arch POC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenPage(),
    );
  }
}
