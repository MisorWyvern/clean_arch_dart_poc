import 'package:clean_arch_dart_poc/core/mapper/mapper.dart';
import 'package:clean_arch_dart_poc/layers/domain/usecases/quest_usecase.dart';
import 'package:clean_arch_dart_poc/layers/infra/dto/quest_dto.dart';
import 'package:dartz/dartz.dart';

class QuestController {
  final QuestUseCase _questUseCase;
  final Mapper _mapper;

  QuestController(this._questUseCase, this._mapper);

  Future<List<QuestDTO>> getQuests() async {
    dynamic result = await _questUseCase.findAll();

    return result.fold(
      (left) => [QuestDTO(id: 0, name: left.props, description: "")],
      (right) => Right(result.map((e) => _mapper.to(e)).toList()),
    );
  }

  Future<String> save(QuestDTO dto) async {
    dynamic result = await _questUseCase.save(_mapper.from(dto));

    return result.fold(
      (left) => ("Something when wrong: " + left.props[0]),
      (right) => ("Success!"),
    );
  }
}
