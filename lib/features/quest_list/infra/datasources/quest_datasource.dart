
import 'package:clean_arch_dart_poc/features/quest_list/infra/dto/quest_dto.dart';

abstract class QuestDataSource {
  Future<void> save(QuestDTO dto);
  Future<List<QuestDTO>> findAll();
}
