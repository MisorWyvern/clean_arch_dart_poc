import 'package:clean_arch_dart_poc/core/database/generic_database.dart';
import 'package:clean_arch_dart_poc/features/quest_list/external/datasources/sqflite/quest_datasource_imp.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/dto/quest_dto.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';

class MockDatabase extends Mock implements Database {}

class MockGenericDatabase extends GenericDatabase<QuestDTO> {
  final _dataSource = QuestDataSourceImp();
  MockDatabase mock;
  MockGenericDatabase(
    this.mock,
  );

  @override
  Future<Database> get db async => mock;

  @override
  QuestDTO fromMap(Map<String, dynamic> map) {
    return _dataSource.fromMap(map);
  }

  @override
  String get tableName => _dataSource.tableName;
}
