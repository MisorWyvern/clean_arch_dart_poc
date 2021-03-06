import 'package:clean_arch_dart_poc/core/mapper/mapper.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/entities/quest.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/dto/quest_dto.dart';

class QuestMapper implements Mapper<QuestDTO, Quest> {
  @override
  Quest from([QuestDTO dto]) => Quest(
        id: dto.id,
        name: dto?.name ?? "",
        description: dto?.description ?? "",
      );

  @override
  QuestDTO to([Quest quest]) => QuestDTO(
        id: quest.id,
        name: quest?.name ?? "",
        description: quest?.description ?? "",
      );
}
