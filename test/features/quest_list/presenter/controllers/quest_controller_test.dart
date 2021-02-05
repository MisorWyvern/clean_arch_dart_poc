import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/quest_usecase.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/dto/quest_dto.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/controllers/quest_controller.dart';
import 'package:clean_arch_dart_poc/features/quest_list/quest_list_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_quest_usecase.dart';

main() {
  initModule(QuestListModule(), changeBinds: [
    Bind<QuestUseCase>((i) => MockQuestUseCase()),
  ]);
  QuestController _controller;

  setUp(() {
    _controller = Modular.get();
  });

  group("Quest Controller Test:", () {
    group("isValidDto Test:", () {
      test("Should return true if dto has a name and description", () {
        _controller.dto = _controller.dto.copyWith(
          name: "test name",
          description: "test desc",
        );

        var result = _controller.isValidDto;

        expect(result, true);
        expect(_controller.dto.name, "test name");
        expect(_controller.dto.description, "test desc");
      });

      test("Should return false if dto has no name or description", () {
        _controller.dto = QuestDTO();

        var result = _controller.isValidDto;

        expect(result, false);

        _controller.dto = _controller.dto.copyWith(
          name: "test",
        );

        result = _controller.isValidDto;

        expect(result, false);

        _controller.dto = QuestDTO();
        _controller.dto = _controller.dto.copyWith(
          description: "test",
        );

        result = _controller.isValidDto;

        expect(result, false);

        _controller.dto = _controller.dto.copyWith(
          name: "test",
          description: "",
        );

        result = _controller.isValidDto;

        expect(result, false);

        _controller.dto = _controller.dto.copyWith(
          name: "",
          description: "test desc",
        );

        result = _controller.isValidDto;

        expect(result, false);
      });
    });
  });
}
