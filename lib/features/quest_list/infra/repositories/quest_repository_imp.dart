import 'package:clean_arch_dart_poc/core/errors/failure.dart';
import 'package:clean_arch_dart_poc/core/mapper/mapper.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/entities/quest.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/repositories/quest_repository.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/datasources/quest_datasource.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/dto/quest_dto.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/errors/repository_exception.dart';
import 'package:dartz/dartz.dart';

class QuestRepositoryImp implements QuestRepository {
  final QuestDataSource _datasource;
  final Mapper _mapper;

  QuestRepositoryImp(
    this._datasource,
    this._mapper,
  );

  @override
  Future<Either<Failure, List<Quest>>> findAll() async {
    try {
      var result = await _datasource.findAll();
      List<Quest> quests = [];
      quests = result.map((e) => _mapper.from(e)).toList().cast();
      return Right(quests);
    } catch (ex) {
      return Left(RepositoryException(
          "RepositoryException: error on find all function."));
    }
  }

  @override
  Future<Either<Failure, Quest>> save(Quest quest) async {
    try {
      QuestDTO dto = _mapper.to(quest);
      await _datasource.save(dto);
      return Right(quest);
    } catch (ex) {
      return Left(
          RepositoryException("RepositoryException: error on save function."));
    }
  }
}
