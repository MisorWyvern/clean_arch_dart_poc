import 'package:flutter_modular/flutter_modular.dart';

class SplashScreenController {
  int delayInSeconds = 3;

  SplashScreenController() {
    Future.delayed(Duration(seconds: delayInSeconds))
        .then((value) => Modular.to.pushReplacementNamed("/questlist"));
  }
}
