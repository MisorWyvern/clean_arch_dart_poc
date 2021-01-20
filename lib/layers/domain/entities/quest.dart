import 'package:equatable/equatable.dart';

class Quest extends Equatable {
  final String name;
  final String description;

  Quest({this.name, this.description});

  isValidQuest() =>
      (name != null || description != null || name != "" || description != "");

  @override
  List<Object> get props => [name, description];
}
