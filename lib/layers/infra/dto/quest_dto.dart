class QuestDTO {
  final int id;
  final String name;
  final String description;

  QuestDTO({this.id, this.name, this.description});

  @override
  String toString() => 'QuestDTO(name: $name, description: $description)';
}
