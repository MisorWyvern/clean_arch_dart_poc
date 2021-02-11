import 'package:clean_arch_dart_poc/features/splash_screen/presenter/controllers/splash_screen_controller.dart';
import 'package:clean_arch_dart_poc/features/splash_screen/splash_screen_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mockito/mockito.dart';

class MockSplashScreenController extends Mock
    implements SplashScreenController {}

class SpySplashScreenModule extends SplashScreenModule {
  @override
  List<Bind> get binds => [
        Bind<SplashScreenController>((i) => MockSplashScreenController()),
        ...super.binds,
      ];
}
