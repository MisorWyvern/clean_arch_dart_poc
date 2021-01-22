import 'package:clean_arch_dart_poc/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/quest_list/quest_list_module.dart';
import 'features/splash_screen/presenter/splash_screen_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => [
    ModularRouter("/", child: (_,__) => SplashScreenPage()),
    ModularRouter("/questlist", module: QuestListModule()),
  ];
}
