import 'package:clean_arch_dart_poc/features/quest_list/infra/dto/quest_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sql.dart';

import 'mocks/mock_database.dart';

main() {
  final _mockDB = MockDatabase();
  final _datasource = MockGenericDatabase(_mockDB);
  List<Map<String, dynamic>> _mapList = [
    {
      "id": 1,
      "name": "name 01",
      "description": "desc 01",
    },
    {
      "id": 2,
      "name": "name 02",
      "description": "desc 02",
    },
  ];
  List<QuestDTO> _dtoList = [
    QuestDTO(
      id: 1,
      name: "name 01",
      description: "desc 01",
    ),
    QuestDTO(
      id: 2,
      name: "name 02",
      description: "desc 02",
    ),
  ];
  test("Should name tables with prefix tb_ and snakecase", () {
    var tableName = _datasource.tableName;

    expect(tableName.contains("tb_"), true);
  });

  group("Test: findAll", () {
    test("Should return a list of QuestDTO on successful findAll", () async {
      when(_mockDB.rawQuery("SELECT * FROM ${_datasource.tableName}", null))
          .thenAnswer((_) async => _mapList);

      var result = await _datasource.findAll();

      expect(result, _dtoList);
      expect(result.length, _dtoList.length);
      verify(_mockDB.rawQuery("SELECT * FROM ${_datasource.tableName}", null))
          .called(1);
    });
  });

  group("Test: save", () {
    test("Should return saved quest id on successful save", () async {
      var _mockDTO =
          QuestDTO(id: null, name: "name 03", description: "desc 03");
      when(_mockDB.insert(
        _datasource.tableName,
        _mockDTO.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      )).thenAnswer((_) async => 3);

      var result = await _datasource.save(_mockDTO);

      expect(result, 3);
      verify(_mockDB.insert(
        _datasource.tableName,
        _mockDTO.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      )).called(1);
    });
  });

  group("Test: delete", () {
    test("Should return number of changes as an int on successful delete",
        () async {
      when(_mockDB.rawDelete(
          "DELETE FROM ${_datasource.tableName} WHERE id = ?",
          [_dtoList[1].id])).thenAnswer((_) async => 1);

      var result = await _datasource.delete(_dtoList[1].id);

      expect(result, isA<int>());
      expect(result, 1);
    });
  });
}
