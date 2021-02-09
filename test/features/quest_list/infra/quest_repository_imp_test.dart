import 'package:clean_arch_dart_poc/core/mapper/mapper.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/entities/quest.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/repositories/quest_repository.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/datasources/quest_datasource.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/dto/quest_dto.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/errors/repository_exception.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/mapper/quest_mapper.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/repositories/quest_repository_imp.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mock_quest_datasource.dart';

main() {
  QuestDataSource _mockDataSource = MockQuestDataSource();
  Mapper _mapper = QuestMapper();
  QuestRepository _repository;

  List<QuestDTO> _dtoList = [
    QuestDTO(
      id: 1,
      name: "mock 1",
      description: "description 1",
    ),
    QuestDTO(
      id: 2,
      name: "mock 2",
      description: "description 2",
    ),
  ];

  setUp(() {
    _repository = QuestRepositoryImp(_mockDataSource, _mapper);
  });

  group("QuestRepositoryImp Test", () {
    group("Test: findAll", () {
      test("Should return a quest list on successful findAll", () async {
        when(_mockDataSource.findAll()).thenAnswer((_) async => _dtoList);

        var result = await _repository.findAll();

        expect(result | null, isA<List<Quest>>());
        expect(result.fold(id, (r) => r.length), 2);
        verify(_mockDataSource.findAll()).called(1);
      });

      test("Should return a failure if findAll fails", () async {
        when(_mockDataSource.findAll()).thenThrow(Exception());

        var result = await _repository.findAll();

        expect(result, isA<Left>());
        expect(result.fold(id, id), isA<RepositoryException>());
      });
    });

    group("Test: save", () {
      test("Should return a quest on successful save", () async {
        final _mockQuest = Quest(
          name: _dtoList[0].name,
          description: _dtoList[0].description,
        );
        when(_mockDataSource.save(argThat(isA<QuestDTO>())))
            .thenAnswer((_) async => 3);

        var result = await _repository.save(_mockQuest);

        expect(result | null, isA<Quest>());
        expect(result.fold(id, (r) => r.id), 3);
        verify(_mockDataSource.save(argThat(isA<QuestDTO>()))).called(1);
      });

      test("Should return a failure if save fails", () async {
        final _mockQuest = Quest(
          name: _dtoList[0].name,
          description: _dtoList[0].description,
        );
        when(_mockDataSource.save(argThat(isA<QuestDTO>())))
            .thenThrow(Exception());

        var result = await _repository.save(_mockQuest);

        expect(result, isA<Left>());
        expect(result.fold(id, id), isA<RepositoryException>());
      });
    });

    group("Test: delete", () {
      test("Should return number of changes as an int on successful delete",
          () async {
        when(_mockDataSource.delete(2)).thenAnswer((_) async => 1);

        var result = await _repository.delete(2);

        expect(result | null, isA<int>());
        expect(result | null, 1);
        verify(_mockDataSource.delete(2)).called(1);
      });

      test("Should return a failure if delete fails", () async {
        when(_mockDataSource.delete(2)).thenThrow(Exception());

        var result = await _repository.delete(2);

        expect(result, isA<Left>());
        expect(result.fold(id, id), isA<RepositoryException>());
      });
    });
  });
}
