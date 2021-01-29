import 'package:clean_arch_dart_poc/core/mapper/mapper.dart';
import 'package:clean_arch_dart_poc/features/quest_list/domain/usecases/quest_usecase.dart';
import 'package:clean_arch_dart_poc/features/quest_list/infra/dto/quest_dto.dart';

import 'package:mobx/mobx.dart';
part 'quest_controller.g.dart';

class QuestController = _QuestControllerBase with _$QuestController;

abstract class _QuestControllerBase with Store {
  final QuestUseCase _questUseCase;
  final Mapper _mapper;

  _QuestControllerBase(this._questUseCase, this._mapper);

  @observable
  QuestDTO dto = QuestDTO();

  @observable
  ObservableList<QuestDTO> questList = <QuestDTO>[].asObservable();

  @computed
  bool get isValidDto {
    if (dto.name == null || dto.description == null) return false;
    if (dto.name == "" || dto.description == "") return false;
    return true;
  }

  @action
  Future<String> updateQuestList() async {
    var result = await _questUseCase.findAll();

    return result.fold(
      (left) => "Something when wrong:" + left.props[0],
      (right) {
        List<QuestDTO> dtoList =
            right.map((e) => _mapper.to(e)).toList().cast();
        questList = dtoList.asObservable();
        return "Update List Success!";
      },
    );
  }

  @action
  Future<String> save() async {
    var result = await _questUseCase.save(_mapper.from(dto));

    return result.fold(
      (left) => ("Something when wrong: " + left.props[0]),
      (right) {
        questList.add(dto);
        dto = dto.copyWith(name: "", description: "", id: null);
        return ("Save Success!");
      },
    );
  }
}
