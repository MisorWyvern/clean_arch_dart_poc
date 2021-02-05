import 'package:clean_arch_dart_poc/core/mapper/mapper.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/repositories/quest_repository.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/delete_quest_usecase.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/delete_quest_usecase_imp.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/quest_usecase_imp.dart';
import 'package:clean_arch_dart_poc/features/quest_list/external/datasources/sqflite/quest_datasource_imp.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/datasources/quest_datasource.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/mapper/quest_mapper.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/repositories/quest_repository_imp.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/controllers/quest_controller.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/pages/add_quest_page.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/pages/quest_list_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/quest_usecase.dart';

class QuestListModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<Mapper>((i) => QuestMapper()),
        Bind<QuestDataSource>((i) => QuestDataSourceImp()),
        Bind<QuestRepository>((i) => QuestRepositoryImp(i.get(), i.get())),
        Bind<QuestUseCase>((i) => QuestUseCaseImp(i.get())),
        Bind<DeleteQuestUseCase>((i) => DeleteQuestUseCaseImp(i.get())),
        Bind((i) => QuestController(i.get(), i.get(), i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter("/", child: (_, __) => QuestListPage()),
        ModularRouter("/addquest", child: (_, __) => AddQuestPage()),
      ];

  static Inject get to => Inject<QuestListModule>.of();
}
