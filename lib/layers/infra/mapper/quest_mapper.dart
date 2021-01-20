import 'package:clean_arch_dart_poc/core/mapper/mapper.dart';
import 'package:clean_arch_dart_poc/layers/domain/entities/quest.dart';
import 'package:clean_arch_dart_poc/layers/infra/dto/quest_dto.dart';

class QuestMapper implements Mapper<QuestDTO, Quest> {
  @override
  Quest from([QuestDTO dto]) => Quest(
        name: dto?.name ?? "",
        description: dto?.description ?? "",
      );

  @override
  QuestDTO to([Quest quest]) => QuestDTO(
        name: quest?.name ?? "",
        description: quest?.description ?? "",
      );
}
