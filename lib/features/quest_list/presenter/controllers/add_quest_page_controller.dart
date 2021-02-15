import 'package:clean_arch_dart_poc/features/quest_list/presenter/controllers/quest_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'add_quest_page_controller.g.dart';

class AddQuestPageController = _AddQuestPageControllerBase
    with _$AddQuestPageController;

abstract class _AddQuestPageControllerBase with Store {
  final QuestController _controller = Modular.get();

  bool get isValidDto => _controller.isValidDto;

  String get name => _controller.dto.name;
  String get description => _controller.dto.description;

  set name(String value) =>
      _controller.dto = _controller.dto.copyWith(name: value);

  set description(String value) =>
      _controller.dto = _controller.dto.copyWith(description: value);

  Future<String> save() => _controller.save();
}
