import 'package:equatable/equatable.dart';

class Quest extends Equatable {
  final int id;
  final String name;
  final String description;

  Quest({this.id, this.name, this.description});

  bool get isValidQuest =>
      (name != null && description != null && name != "" && description != "");

  @override
  List<Object> get props => [id, name, description];

  @override
  bool get stringify => true;
}
