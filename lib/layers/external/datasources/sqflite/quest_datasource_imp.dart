import 'package:clean_arch_dart_poc/core/database/generic_database.dart';
import 'package:clean_arch_dart_poc/layers/infra/datasources/quest_datasource.dart';
import 'package:clean_arch_dart_poc/layers/infra/dto/quest_dto.dart';

class QuestDataSourceImp extends GenericDatabase<QuestDTO>
    implements QuestDataSource {
  @override
  String get tableName => "tb_quests";

  @override
  QuestDTO fromMap(Map<String, dynamic> map) {
    QuestDTO dto = QuestDTO();
    return dto.fromMap(map);
  }
}
