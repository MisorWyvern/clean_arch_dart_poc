
import 'package:clean_arch_dart_poc/core/errors/failure.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/errors/usecase_exception.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/repositories/quest_repository.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/delete_quest_usecase.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/delete_quest_usecase_imp.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/errors/repository_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks/quest_list_mocks.dart';

void main() {
  QuestRepository _repository;
  DeleteQuestUseCase _useCase;

  setUp(() async {
    _repository = MockQuestRepository();
    _useCase = DeleteQuestUseCaseImp(_repository);
  });

  test("Should return number of changes on delete call", () async{
    int _testId = 2;
    when(_repository.delete(_testId)).thenAnswer((_) async => Right<Failure,int>(1));

    var result = await _useCase.delete(_testId);

    expect(result, Right<Failure,int>(1));
  });

  test("Should return a Failure on delete call if id was not found or invalid", () async{
    int _testId = 2;
    when(_repository.delete(_testId)).thenAnswer((_) async => Left<Failure,int>(RepositoryException("RepositoryException: mock error")));

    var result = await _useCase.delete(_testId);

    expect(result, Left<Failure,int>(UseCaseException("UseCase Exception: error on delete function.")));
  });
}
