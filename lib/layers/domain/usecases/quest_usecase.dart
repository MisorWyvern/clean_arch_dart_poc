import 'package:clean_arch_dart_poc/layers/domain/entities/quest.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';

abstract class QuestUseCase {
  Future<Either<Failure, Quest>> save(Quest quest);
  Future<Either<Failure, List<Quest>>> findAll();
}
