import 'package:clean_arch_dart_poc/core/errors/failure.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/entities/quest.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/errors/entity_exception.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/errors/usecase_exception.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/repositories/quest_repository.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/quest_usecase.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/quest_usecase_imp.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/errors/repository_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mock_quest_repository.dart';

void main() {
  QuestRepository _repository;
  QuestUseCase _useCase;
  List<Quest> _mockQuestList = [
    Quest(id: 1, name: "Test Quest 01", description: "Description 001")
  ];

  setUp(() async {
    _repository = MockQuestRepository();
    _useCase = QuestUseCaseImp(_repository);
  });

  test("Should return a quest list on findAll call", () async {
    when(_repository.findAll()).thenAnswer((_) async => Right(_mockQuestList));

    var result = await _useCase.findAll();

    expect(result | null, _mockQuestList);
  });

  test("Should return a Failure if findAll call fails", () async {
    when(_repository.findAll()).thenAnswer((_) async =>
        Left(RepositoryException("RepositoryException: mock error")));

    var result = await _useCase.findAll();

    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<UseCaseException>());
  });

  test("Should return a quest on save call", () async {
    Quest _testQuest = Quest(
      id: null,
      name: "Test Quest 001",
      description: "Description 001",
    );

    when(_repository.save(_testQuest))
        .thenAnswer((_) async => Right<Failure, Quest>(_mockQuestList[0]));

    var result = await _useCase.save(_testQuest);

    expect(result.getOrElse(() => null), _mockQuestList[0]);
  });

  test("Should return a Failure on save call with invalid Quest", () async {
    Quest _testQuest = Quest();

    var result = await _useCase.save(_testQuest);

    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<EntityException>());
  });

  test("Should return a Failure on save call with repository error", () async {
    Quest _testQuest = Quest(
      id: null,
      name: "Test Quest 001",
      description: "Description 001",
    );

    when(_repository.save(_testQuest)).thenAnswer((_) async =>
        Left<Failure, Quest>(
            RepositoryException("RepositoryException: mock error")));

    var result = await _useCase.save(_testQuest);

    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<UseCaseException>());
  });
}
