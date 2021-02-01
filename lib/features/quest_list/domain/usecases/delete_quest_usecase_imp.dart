import 'package:clean_arch_dart_poc/core/errors/failure.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/errors/usecase_exception.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/repositories/quest_repository.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/delete_quest_usecase.dart';
import 'package:dartz/dartz.dart';

class DeleteQuestUseCaseImp implements DeleteQuestUseCase {
  final QuestRepository _repository;

  DeleteQuestUseCaseImp(
    this._repository,
  );

  @override
  Future<Either<Failure, int>> delete(int id) async {
    var result = await _repository.delete(id);
    return result.fold(
      (l) => Left(
          UseCaseException("UseCase Exception: error on delete function.")),
      (r) => Right(r),
    );
  }
}
