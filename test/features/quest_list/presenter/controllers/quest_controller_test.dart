import 'dart:math';

import 'package:clean_arch_dart_poc/features/quest_list/domain/entities/quest.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/errors/usecase_exception.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/delete_quest_usecase.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/quest_usecase.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/dto/quest_dto.dart';
import 'package:clean_arch_dart_poc/features/quest_list/presenter/controllers/quest_controller.dart';
import 'package:clean_arch_dart_poc/features/quest_list/quest_list_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart' as modular;
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mock_delete_quest_usecase.dart';
import 'mocks/mock_quest_usecase.dart';

main() {
  QuestUseCase _mockQuestUseCase = MockQuestUseCase();
  DeleteQuestUseCase _mockDeleteQuestUseCase = MockDeleteQuestUseCase();
  QuestController _controller;
  List<Quest> _questListResult = [
    Quest(
      name: "test quest 01",
      description: "test desc 01",
      id: 1,
    ),
    Quest(
      name: "test quest 02",
      description: "test desc 02",
      id: 2,
    ),
  ];

  initModule(QuestListModule(), changeBinds: [
    modular.Bind<QuestUseCase>((i) => _mockQuestUseCase),
    modular.Bind<DeleteQuestUseCase>((i) => _mockDeleteQuestUseCase),
  ]);

  setUp(() {
    _controller = modular.Modular.get();
    expect(_controller, isInstanceOf<QuestController>());
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

    group("updateQuestList Test", () {
      test(
          "Should update quest list and return a sucess string on successful updateQuestList",
          () async {
        when(_mockQuestUseCase.findAll())
            .thenAnswer((_) async => Right(_questListResult));

        String result = await _controller.updateQuestList();

        expect(result.contains("Success"), true);
        expect(_controller.questList.length, 2);

        result = await _controller.updateQuestList();

        expect(result.contains("Success"), true);
        expect(_controller.questList.length, 2);
        _controller.questList.removeLast();
        _controller.questList.removeLast();
      });

      test(
          "Should not update quest list and return a error string if updateQuestList fails",
          () async {
        when(_mockQuestUseCase.findAll()).thenAnswer((_) async =>
            Left(UseCaseException("UseCase Exception: mock error")));

        String result = await _controller.updateQuestList();

        expect(result.contains("Something went wrong:"), true);
        expect(_controller.questList.length, 0);
      });
    });

    group("save Test", () {
      test("Should return a success string on successful save", () async {
        when(_mockQuestUseCase.save(argThat(isA<Quest>())))
            .thenAnswer((_) async => Right(_questListResult[0]));

        String result = await _controller.save();

        expect(result.contains("Success"), true);
        expect(_controller.questList.length, 1);
        _controller.questList.removeLast();
        verify(_mockQuestUseCase.save(argThat(isA<Quest>()))).called(1);
      });

      test("Should return a error string if save fails", () async {
        when(_mockQuestUseCase.save(argThat(isA<Quest>()))).thenAnswer(
            (_) async =>
                Left(UseCaseException("UseCase Exception: mock error")));

        String result = await _controller.save();

        expect(result.contains("Something went wrong:"), true);
        expect(_controller.questList.length, 0);
      });
    });

    group("delete Test", () {
      test("Should return a success string on successful delete", () async {
        _controller.questList.add(QuestDTO(id: 3));
        when(_mockDeleteQuestUseCase.delete(3))
            .thenAnswer((_) async => Right(1));

        String result = await _controller.delete(3);

        expect(result.contains("Success"), true);
        expect(_controller.questList.length, 0);
        verify(_mockDeleteQuestUseCase.delete(3)).called(1);
      });

      test("Should return a error string if delete fails", () async {
        _controller.questList.add(QuestDTO(id: 3));
        when(_mockDeleteQuestUseCase.delete(3)).thenAnswer((_) async =>
            Left(UseCaseException("UseCase Exception: mock error")));

        String result = await _controller.delete(3);

        expect(result.contains("Something went wrong:"), true);
        expect(_controller.questList.length, 1);
        _controller.questList.removeLast();
      });
    });
  });
}
