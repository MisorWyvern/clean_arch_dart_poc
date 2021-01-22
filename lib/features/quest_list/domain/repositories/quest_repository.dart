import 'package:clean_arch_dart_poc/core/errors/failure.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/entities/quest.dart';
import 'package:dartz/dartz.dart';


abstract class QuestRepository {
  Future<Either<Failure, Quest>> save(Quest quest);
  Future<Either<Failure, List<Quest>>> findAll();
}
