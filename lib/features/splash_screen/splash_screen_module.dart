import 'package:clean_arch_dart_poc/features/splash_screen/presenter/controllers/splash_screen_controller.dart';
import 'package:clean_arch_dart_poc/features/splash_screen/presenter/pages/splash_screen_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreenModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashScreenController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter("/", child: (_, __) => SplashScreenPage()),
      ];

  static Inject get to => Inject<SplashScreenModule>.of();
}
