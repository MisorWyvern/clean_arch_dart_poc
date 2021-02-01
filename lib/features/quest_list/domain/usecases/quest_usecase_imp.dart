import 'package:clean_arch_dart_poc/core/errors/failure.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/entities/quest.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/errors/entity_exception.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/errors/usecase_exception.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/repositories/quest_repository.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/quest_usecase.dart';
import 'package:dartz/dartz.dart';

class QuestUseCaseImp implements QuestUseCase {
  final QuestRepository _repository;

  QuestUseCaseImp(this._repository);

  @override
  Future<Either<Failure, List<Quest>>> findAll() async {
    var result = await _repository.findAll();
    return result.fold(
      (left) => Left(
          UseCaseException("UseCase Exception: error on find all function.")),
      (right) => Right(right),
    );
  }

  @override
  Future<Either<Failure, Quest>> save(Quest quest) async {
    if (quest.isValidQuest == false) {
      return Left(EntityException("EntityException: quest is not valid."));
    }

    var result = await _repository.save(quest);
    return result.fold(
      (left) =>
          Left(UseCaseException("UseCaseException: error on save function.")),
      (right) => Right(right),
    );
  }
}
