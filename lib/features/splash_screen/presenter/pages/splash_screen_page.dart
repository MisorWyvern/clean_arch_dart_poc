import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:clean_arch_dart_poc/features/splash_screen/presenter/controllers/splash_screen_controller.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState
    extends ModularState<SplashScreenPage, SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _theme.primaryColorLight,
            _theme.primaryColor,
            _theme.primaryColorDark
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png"),
          Padding(
            padding: const EdgeInsets.only(top: 8.0 * 2),
            child: Text(
              "DailyQs",
              style: _theme.textTheme.headline1,
            ),
          )
        ],
      ),
    );
  }
}
