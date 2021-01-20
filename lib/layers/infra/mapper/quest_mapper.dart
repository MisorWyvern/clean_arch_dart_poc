import 'package:clean_arch_dart_poc/core/mapper/mapper.dart';
import 'package:clean_arch_dart_poc/layers/domain/entities/quest.dart';
import 'package:clean_arch_dart_poc/layers/infra/dto/quest_dto.dart';

class QuestMapper implements Mapper<QuestDTO, Quest> {
  @override
  Quest from([QuestDTO dto]) => Quest(
        id: dto?.id ?? 0,
        name: dto?.name ?? "",
        description: dto?.description ?? "",
      );

  @override
  QuestDTO to([Quest quest]) => QuestDTO(
        id: quest?.id ?? 0,
        name: quest?.name ?? "",
        description: quest?.description ?? "",
      );
}
