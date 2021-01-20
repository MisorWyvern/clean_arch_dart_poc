import 'package:clean_arch_dart_poc/layers/infra/datasources/quest_datasource.dart';
import 'package:clean_arch_dart_poc/layers/infra/dto/quest_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuestDataSourceImp implements QuestDataSource {
  final String _questsTable = "tb_quests";

  Future<Database> createDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    String dbPath = await getDatabasesPath();

    final String path = join(dbPath, "quests.db");

    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute("""
        CREATE TABLE $_questsTable(
          id INTEGER PRIMARY KEY,
          name TEXT,
          description TEXT
        );
        """);
      },
      version: 1,
    );
  }

  @override
  Future<List<QuestDTO>> findAll() async {
    Database db = await createDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_questsTable);

    final List<QuestDTO> quests = List();
    maps.forEach((quest) {
      final dto = QuestDTO(
        name: quest["name"],
        description: quest["description"],
      );
      quests.add(dto);
    });

    return quests;
  }

  @override
  Future<void> save(QuestDTO dto) async {
    Database db = await createDatabase();

    final Map<String, dynamic> questMap = {};
    questMap['name'] = dto.name;
    questMap['description'] = dto.description;

    return db.insert(_questsTable, questMap);
  }
}
