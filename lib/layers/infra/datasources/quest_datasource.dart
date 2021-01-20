import 'package:clean_arch_dart_poc/layers/infra/dto/quest_dto.dart';

abstract class QuestDataSource {
  Future<void> save(QuestDTO dto);
  Future<List<QuestDTO>> findAll();
}
