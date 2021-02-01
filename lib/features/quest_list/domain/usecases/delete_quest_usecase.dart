import 'package:clean_arch_dart_poc/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class DeleteQuestUseCase {
  Future<Either<Failure, int>> delete(int id);
}
